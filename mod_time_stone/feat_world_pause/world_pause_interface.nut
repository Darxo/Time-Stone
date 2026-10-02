::MSU.Table.merge(::TimeStone.Const, {
	Event = {
		CaravanNearbyTownAccessible = "Event.CaravanNearbyTownAccessible",
		DiscoverHostileParty = "Event.DiscoverHostileParty",
		DiscoverAlliedParty = "Event.DiscoverAlliedParty",
		DiscoverHostileAttackableLocation = "Event.DiscoverHostileAttackableLocation",
		DiscoverUniqueLocation = "Event.DiscoverUniqueLocation",
		LeaveUIScreen = "Event.LeaveUIScreen",		// Includes anything that uses the menu_stack
		Nightfall = "Event.Nightfall",
		Sunrise = "Event.Sunrise",
	},
});

::TimeStone.WorldPause <- {
	m = {
	// Private
		LastPauseTriggered = 0,		// time stamp in seconds when one of our events has last paused the game
		HasPendingAutoPause = false,
		HasPendingPause = false,
	},

	function triggerEvent( _event )
	{
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
					this.queueAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.DiscoverAlliedParty:
			{
				break;
			}
			case ::TimeStone.Const.Event.DiscoverHostileAttackableLocation:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.DiscoverHostileAttackableLocation").getValue())
				{
					this.queueAutoPause();
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
					this.queueAutoPause();
				}
				break;
			}
			case ::TimeStone.Const.Event.LeaveUIScreen:
			{
				if (::TimeStone.Mod.ModSettings.getSetting("AutoPause.LeaveEventScreen").getValue())
				{
					// We don't trigger an autopause here because we don't require unpause protection in this scenario
					// A long unpause protection time would only irritate a player who wants to quickly unpause and move on
					this.queuePause();
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
							this.queueAutoPause();
						}
						else if (nearbyEntity.isAlliedWithPlayer() && ::MSU.isKindOf(nearbyEntity, "settlement") && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.SunriseAlliedSettlement").getValue())
						{
							this.queueAutoPause();
						}
					}
					else
					{
						if (!nearbyEntity.isAlliedWithPlayer() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.SunriseHostileParty").getValue())
						{
							this.queueAutoPause();
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
							this.queueAutoPause();
						}
					}
					else
					{
						if (!nearbyEntity.isAlliedWithPlayer() && ::TimeStone.Mod.ModSettings.getSetting("AutoPause.NightfallHostileParty").getValue())
						{
							this.queueAutoPause();
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

	// Signal to the world_state, that it should pause the game when it has time to do so
	// We can't pause the game immediately as this causes weird random ui glitches and crashes
	// I was not able to fully understand it but I assume that some important processes in the update loop don't finish correctly if the game is paused in between them
	function queueAutoPause()
	{
		this.m.HasPendingAutoPause = true;
	}

	// Signal to the world_state, that it should pause the game when it has time to do so
	// We can't pause the game immediately as this causes weird random ui glitches and crashes
	// I was not able to fully understand it but I assume that some important processes in the update loop don't finish correctly if the game is paused in between them
	function queuePause()
	{
		this.m.HasPendingPause = true;
	}

	// This is called from world_state::onUpdate()
	function hasPendingAutoPause()
	{
		return this.m.HasPendingAutoPause;
	}

	// Execute everything that should happen, when our mod pauses the game in response to an event
	// This is called from world_state::onUpdate()
	function executeAutoPause()
	{
		this.m.HasPendingAutoPause = false;
		this.m.LastPauseTriggered = ::Time.getRealTimeF();
		::World.State.setPause(true);
		::World.TopbarDayTimeModule.TS_shakePauseButton();
	}

	// This is called from world_state::onUpdate()
	function hasPendingPause()
	{
		return this.m.HasPendingPause;
	}

	// This is called from world_state::onUpdate()
	function executePause()
	{
		this.m.HasPendingPause = false;
		::World.State.setPause(true);
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
