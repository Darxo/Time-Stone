::MSU.Table.merge(::TimeStone.Const, {
	SpeedState = {
		Normal = 1,
		Fast = 2,
	},
	SpeedAction = {
		SetNormal = "SpeedAction.SetNormal",
		SetFast = "SpeedAction.SetFast",
	},
	SpeedSettingTemplate = {
		VirtualClockMult = 1.0,
		CameraSpeedMult = 1.0,
		UISpeendMult = 1.0,
		AISpeedMult = 1.0,
		SkillSpeedMult = 1.0,
	},
});

::TimeStone.TacticalSpeed <- {
	m = {
	// Private
		CurrentSpeedState = ::TimeStone.Const.SpeedState.Normal,
		SpeedSettings = {},
	},

	function init()
	{
		foreach (entry in ::TimeStone.Const.SpeedState)
		{
			local speedSetting = clone ::TimeStone.Const.SpeedSettingTemplate;
			this.m.SpeedSettings[entry] <- speedSetting;
		}
	}

	function triggerAction( _speedAction )
	{
		if (!this.__isValidEntry(_speedAction, ::TimeStone.Const.SpeedAction))
		{
			::logWarning("TimeStone: unknown _speedAction " + _speedAction);
			return;
		}

		switch (_speedAction)
		{
			case ::TimeStone.Const.SpeedAction.SetNormal:
			{
				this.setSpeedState(::TimeStone.Const.SpeedState.Normal);
				break;
			}
			case ::TimeStone.Const.SpeedAction.SetFast:
			{
				this.setSpeedState(::TimeStone.Const.SpeedState.Fast);
				break;
			}
		}
	}

	function setSpeedState( _speedState )
	{
		if (!this.__isValidEntry(_speedState, ::TimeStone.Const.SpeedState))
		{
			::logWarning("TimeStone: unknown _speedAction " + _speedState);
			return;
		}

		switch (_speedState)
		{
			case ::TimeStone.Const.SpeedState.Normal:
			case ::TimeStone.Const.SpeedState.Fast:
			{
				this.m.CurrentSpeedState = _speedState;

				if (::Tactical.isActive())
				{
					::Tactical.State.setPause(false);
				}
				break;
			}
		}
	}

	/// Read out all tactical speed related mod settings and write them into the local speed states
	function applyModSettings()
	{
		local normalState = this.m.SpeedSettings[::TimeStone.Const.SpeedState.Normal];
		normalState.VirtualClockMult = ::TimeStone.Mod.ModSettings.getSetting("TacticalSpeed.Normal.VirtualClockMult").getValue();
		normalState.UISpeendMult = ::TimeStone.Mod.ModSettings.getSetting("TacticalSpeed.Normal.UISpeedMult").getValue();

		local fastState = this.m.SpeedSettings[::TimeStone.Const.SpeedState.Fast];
		fastState.VirtualClockMult = ::TimeStone.Mod.ModSettings.getSetting("TacticalSpeed.Fast.VirtualClockMult").getValue();
		fastState.UISpeendMult = ::TimeStone.Mod.ModSettings.getSetting("TacticalSpeed.Fast.UISpeedMult").getValue();
	}

	/// Triggered, whenever ::Tactical.State.setPause(false) is called
	function onUnpause()
	{
		// Feat: after unpausing, overwrite the vanilla assigned speed changes with our own ones
		this.applyCurrentSpeedSetting();
	}

	/// Apply the speed setting from this.m.CurrentSpeedState to the tactical game
	function applyCurrentSpeedSetting()
	{
		local currentSpeedSetting = this.m.SpeedSettings[this.m.CurrentSpeedState];

		this.__applyVirtualSpeedMult(currentSpeedSetting.VirtualClockMult)

		// Inverted, because multiply it against durations
		this.__applyUISpeedMult(1.0 / currentSpeedSetting.UISpeendMult)
	}

// Private
	function __isValidEntry( _value, _table )
	{
		foreach (entry in _table)
		{
			if (_value == entry) return true;
		}

		return false;
	}

	function __setPause( _bool )
	{
		if (::Tactical.isActive())
		{
			::Tactical.State.setPause(_bool);
		}
	}

	function __applyVirtualSpeedMult( _mult )
	{
		::Time.setVirtualSpeed(_mult);
	}

	function __applyUISpeedMult( _mult )
	{
		if ("TurnSequenceBar" in ::Tactical && !::MSU.isNull(::Tactical.TurnSequenceBar))
		{
			::Tactical.TurnSequenceBar.TS_applyDurationMultiplier(_mult);
		}
	}
};

::TimeStone.TacticalSpeed.init();
