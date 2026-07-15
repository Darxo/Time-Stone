{	// Auto Pause Events
	local worldAutoPausePage = ::TimeStone.Mod.ModSettings.addPage("Auto Pause");

	{	// Auto Pause Events
		worldAutoPausePage.addTitle("WorldAutoPauseTitleEvents", "Events");

		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverHostileParty", true, "Discover Hostile Party", "Pause the game whenever you discover a hostile party");
		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverHostileAttackableLocation", false, "Discover Hostile Camp", "Pause the game whenever you discover an attackable hostile location");
		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverUniqueLocation", false, "Discover Unique Location", "Pause the game whenever you discover a unique location");

		worldAutoPausePage.addDivider("MiscDivider1");

		worldAutoPausePage.addBooleanSetting("AutoPause.LeaveEventScreen", true, "Leave Event/Contract Screen", "Pause the game whenever you close either the event screen or the contract screen");

		worldAutoPausePage.addDivider("MiscDivider2");

		worldAutoPausePage.addBooleanSetting("AutoPause.SunriseAlliedSettlement", false, "Sunrise Near Allied Settlement", "Pause the game whenever it becomes day while there is an allied settlement within combat distance (" + ::Const.World.CombatSettings.CombatPlayerDistance + " units)");

		worldAutoPausePage.addDivider("MiscDivider3");

		worldAutoPausePage.addBooleanSetting("AutoPause.SunriseHostileParty", false, "Sunrise Near Hostile Party", "Pause the game whenever it becomes day while there is a hostile party within combat distance (" + ::Const.World.CombatSettings.CombatPlayerDistance + " units)");
		worldAutoPausePage.addBooleanSetting("AutoPause.NightfallHostileParty", false, "Nightfall Near Hostile Party", "Pause the game whenever it becomes day while there is a hostile party within combat distance (" + ::Const.World.CombatSettings.CombatPlayerDistance + " units)");
		worldAutoPausePage.addBooleanSetting("AutoPause.SunriseAttackableLocation", false, "Sunrise Near Attackable Location", "Pause the game whenever it becomes day while there is an attackable location within combat distance (" + ::Const.World.CombatSettings.CombatPlayerDistance + " units)");
		worldAutoPausePage.addBooleanSetting("AutoPause.NightfallAttackableLocation", false, "Nightfall Near Attackable Location", "Pause the game whenever it becomes night while there is an attackable location within combat distance (" + ::Const.World.CombatSettings.CombatPlayerDistance + " units)");
	}

	worldAutoPausePage.addTitle("WorldAutoPauseTitleMisc", "Misc");

	{	// Smart
		worldAutoPausePage.addRangeSetting("UnpauseProtectionInSeconds", 0.5, 0.0, 1.0, 0.1, "Unpause Protection", "Prevent unpausing of the game for this many seconds whenever the game was paused because of one of the above Auto Pause Events");

		worldAutoPausePage.addRangeSetting("ForgetPartiesAfterXHours", 2, 0, 24, 1, "Forget Parties after X hours", "Any world party that you have not seen for this many ingame hours will re-trigger an autopause if the respective setting is also activated.\n\nA value of 0 can cause parties at the edge of your vision to softlock you on the world map until you increase this value");
	}

	{	// Audio
		worldAutoPausePage.addBooleanSetting("AutoPause.ReplayDiscoveredSound", true, "Replay Discovered Sound", "Replay the discover sound when meeting hostile parties again that you forgot");
		worldAutoPausePage.addBooleanSetting("AutoPause.PlayUniqueLocationDiscoveredSound", true, "Play Unique Location Sound", "Play a unique sound when discovering any unique location");
	}
}
