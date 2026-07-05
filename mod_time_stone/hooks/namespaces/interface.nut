::TimeStone.Const <- {
	Event = {
		CaravanNearbyTownAccessible = "Event.CaravanNearbyTownAccessible",
		DiscoverHostileParty = "Event.DiscoverHostileParty",
		DiscoverAlliesParty = "Event.DiscoverAlliesParty",
		DiscoverHostileAttackableLocation = "Event.DiscoverHostileAttackableLocation",
		DiscoverUniqueLocation = "Event.DiscoverUniqueLocation",
		LeaveEventScreen = "Event.LeaveEventScreen",	// The event screen is used for both events and contracts
		Nightfall = "Event.Nightfall",
		Sunrise = "Event.Sunrise",
	},
};

::TimeStone.Interface <- {
	m = {
	// Private
		LastPauseTriggered = 0,		// time stamp in seconds when one of our events has last paused the game
	},

	function triggerEvent( _event )
	{
		// ::logWarning("TimeStone: triggerEvent " + _event);

		if (!this.__isValidEntry(_event, ::TimeStone.Const.Event))
		{
			::logWarning("TimeStone: unknown _event " + _event);
			return;
		}

		switch (_event)
		{
			case ::TimeStone.Const.Event.DiscoverHostileParty:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.ReplayDiscoveredSound").getValue())
				{
					::World.State.playEnemyDiscoveredSound();
				}

				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.DiscoverHostileParty").getValue())
				{
					this.triggerAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.DiscoverAlliesParty:
			{
				break;
			}
			case ::TimeStone.Const.Event.DiscoverHostileAttackableLocation:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.DiscoverHostileAttackableLocation").getValue())
				{
					this.triggerAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.DiscoverUniqueLocation:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.PlayUniqueLocationDiscoveredSound").getValue())
				{
					::World.State.TS_playUniqueLocationDiscoveredSound();
				}

				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.DiscoverUniqueLocation").getValue())
				{
					this.triggerAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.LeaveEventScreen:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.NightfallAttackableLocation").getValue())
				{
					this.triggerAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.Sunrise:
			{
				foreach (nearbyEntity in ::World.getAllEntitiesAtPos(::World.State.getPlayer().getPos(), ::Const.World.CombatSettings.CombatPlayerDistance))
				{
					if (nearbyEntity.isLocation())
					{
						if (nearbyEntity.isAttackable() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.SunriseAttackableLocation").getValue())
						{
							this.triggerAutoPause();
						}
					}
					else
					{
						if (!nearbyEntity.isAlliedWithPlayer() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.SunriseHostileParty").getValue())
						{
							this.triggerAutoPause();
						}
					}
				}
				break;
			}
			case ::TimeStone.Const.Event.Nightfall:
			{
				foreach (nearbyEntity in ::World.getAllEntitiesAtPos(::World.State.getPlayer().getPos(), ::Const.World.CombatSettings.CombatPlayerDistance))
				{
					if (nearbyEntity.isLocation())
					{
						if (nearbyEntity.isAttackable() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.NightfallAttackableLocation").getValue())
						{
							this.triggerAutoPause();
						}
					}
					else
					{
						if (!nearbyEntity.isAlliedWithPlayer() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.NightfallHostileParty").getValue())
						{
							this.triggerAutoPause();
						}
					}
				}
				break;
			}
			case ::TimeStone.Const.Event.CaravanNearbyTownAccessible:
			{
				break;
			}
		}
	}

	// Pause the game on the world map and initiate an unpause protection
	function triggerAutoPause()
	{
		this.m.LastPauseTriggered = ::Time.getRealTimeF();
		::World.State.setPause(true);
		::World.TopbarDayTimeModule.TS_shakePauseButton();
	}

	function isUnpauseProtected()
	{
		local protectionDuration = ::TimeStone.Mod.ModSettings.getSetting("UnpauseProtectionInSeconds").getValue();
		return this.m.LastPauseTriggered + protectionDuration > ::Time.getRealTimeF();
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
};
