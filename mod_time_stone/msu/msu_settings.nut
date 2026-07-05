{	// World Speed
	local worldSpeedPage = ::TimeStone.Mod.ModSettings.addPage("World Speed");

	{	// Vanilla Mults
		worldSpeedPage.addRangeSetting("SpeedSettingsNormalMult", ::Const.World.SpeedSettings.NormalMult, 1.0, 8.0, 0.2, "Normal Speed", "Normal World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.NormalMult = _newValue);

		worldSpeedPage.addRangeSetting("SpeedSettingsFastMult", ::Const.World.SpeedSettings.FastMult, 1.0, 8.0, 0.2, "Fast Speed", "Fast World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.FastMult = _newValue);

		worldSpeedPage.addRangeSetting("SpeedSettingsVeryFastMult", ::Const.World.SpeedSettings.VeryFastMult, 1.0, 16.0, 0.5, "Very Fast Speed", "Very Fast World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.VeryFastMult = _newValue);

		worldSpeedPage.addDivider("MiscDivider2");
	}
}

{	// Auto Pause Events
	local worldAutoPausePage = ::TimeStone.Mod.ModSettings.addPage("Auto Pause Events");

	{	// Auto Pause Events
		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverHostileParty", true, "Discover Hostile Party", "Pause the game whenever you discover a hostile party");
		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverHostileAttackableLocation", false, "Discover Hostile Camp", "Pause the game whenever you discover an attackable hostile location");
		worldAutoPausePage.addBooleanSetting("AutoPause.DiscoverUniqueLocation", false, "Discover Unique Location", "Pause the game whenever you discover a unique location");

		worldAutoPausePage.addDivider("MiscDivider1");

		worldAutoPausePage.addBooleanSetting("AutoPause.LeaveEventScreen", true, "Leave Event/Contract Screen", "Pause the game whenever you close either the event screen or the contract screen");

		worldAutoPausePage.addDivider("MiscDivider2");

		worldAutoPausePage.addBooleanSetting("AutoPause.SunriseHostileParty", false, "Sunrise Near Hostile Party", "Pause the game whenever it becomes day while there is a hostile party nearby");
		worldAutoPausePage.addBooleanSetting("AutoPause.NightfallHostileParty", false, "Nightfall Near Hostile Party", "Pause the game whenever it becomes day while there is a hostile party nearby");
		worldAutoPausePage.addBooleanSetting("AutoPause.SunriseAttackableLocation", false, "Sunrise Near Attackable Location", "Pause the game whenever it becomes day while there is an attackable location nearby");
		worldAutoPausePage.addBooleanSetting("AutoPause.NightfallAttackableLocation", false, "Nightfall Near Attackable Location", "Pause the game whenever it becomes night while there is an attackable location nearby");

		worldAutoPausePage.addDivider("MiscDivider3");
	}

	{	// Smart Systems
		worldAutoPausePage.addRangeSetting("UnpauseProtectionInSeconds", 0.5, 0.0, 1.0, 0.1, "Unpause Protection", "Prevent unpausing of the game for this many seconds whenever the game was paused because of one of the above Auto Pause Events");

		worldAutoPausePage.addRangeSetting("ForgetPartiesAfterXHours", 2, 0, 24, 1, "Forget Parties after X hours", "Any world party that you have not seen for this many ingame hours will re-trigger an autopause if the respective setting is also activated.\n\nA value of 0 can cause parties at the edge of your vision to softlock you on the world map until you increase this value");

		worldAutoPausePage.addDivider("MiscDivider4");
	}

	{	// Audio
		worldAutoPausePage.addBooleanSetting("AutoPause.ReplayDiscoveredSound", true, "Replay Discovered Sound", "Replay the discover sound when meeting hostile parties again that you forgot");
		worldAutoPausePage.addBooleanSetting("AutoPause.PlayUniqueLocationDiscoveredSound", true, "Play Unique Location Sound", "Play a unique sound when discovering any unique location");
	}
}
