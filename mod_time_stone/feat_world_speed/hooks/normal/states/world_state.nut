::TimeStone.HooksMod.hook("scripts/states/world_state", function(q) {
	q.onInit = @(__original) { function onInit()
	{
		__original();

		// We no longer support this value and therefore set it to 0.0
		this.m.MinWorldSpeedMult = 0.0;
	}}.onInit;

	q.setNormalTime = @(__original) { function setNormalTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setNormalTime;

	q.setFastTime = @(__original) { function setFastTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setFastTime;

	q.setVeryFastTime = @(__original) { function setVeryFastTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setVeryFastTime;

	q.setMinWorldSpeedMult = @(__original) { function setMinWorldSpeedMult( _value )
	{
		// We no longer support this value and therefore set it to 0.0
		__original(0.0);
	}}.setMinWorldSpeedMult;

	q.updateTopBarButtonState = @(__original) { function updateTopBarButtonState()
	{
		if (!::MSU.isNull(::World.TopbarDayTimeModule) && ::TimeStone.Mod.ModSettings.getSetting("NeverDisableSpeedButtons").getValue())
		{
			// We make sure all time buttons are enabled
			::World.TopbarDayTimeModule.enableNormalTimeButton(true);
			::World.TopbarDayTimeModule.enableFastTimeButton(true);
			::World.TopbarDayTimeModule.enableVeryFastTimeButton(true);

			// Then we replicate the vanilla code for
			if (this.isPaused())
			{
				::World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			else
			{
				switch (::World.getSpeedMult())
				{
					case ::Const.World.SpeedSettings.NormalMult:
						::World.TopbarDayTimeModule.updateTimeButtons(1);
						break;
					case ::Const.World.SpeedSettings.FastMult:
						::World.TopbarDayTimeModule.updateTimeButtons(2);
						break;
					case ::Const.World.SpeedSettings.VeryFastMult:
						::World.TopbarDayTimeModule.updateTimeButtons(3);
						break;
					default:
						// If there is currently a custom speed multiplier, we disable all
						::World.TopbarDayTimeModule.updateTimeButtons(-1);
				}
			}

			return;
		}

		__original();
	}}.updateTopBarButtonState;
});
