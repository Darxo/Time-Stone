local tacticalSpeedPage = ::TimeStone.Mod.ModSettings.addPage("Tactical Speed");

{	// Possible Speed States
	local speedSettingCallback = function()
	{
		::TimeStone.TacticalSpeed.applyModSettings();
	}

	{	// Normal
		tacticalSpeedPage.addTitle("TacticalSpeedTitleNormal", "Normal Speed");

		tacticalSpeedPage.addRangeSetting("TacticalSpeed.Normal.VirtualClockMult", 1.0, 1.0, 4.0, 0.1, "Virtual Clock", "Multiplier for the virtual clock during tactical combat. \nIt affects movement speed and animation speed of characters and the delay between skill use.\n\n1.0 is the vanilla default and will cause the least issues").addAfterChangeCallback(@ (_newValue) speedSettingCallback());

		tacticalSpeedPage.addRangeSetting("TacticalSpeed.Normal.UISpeedMult", 1.0, 1.0, 4.0, 0.1, "UI Speed", "Multiplier for how fast the User Interface animates during combat. \nIt speeds up the Turn Sequence Bar, by lowering delays and durations related to it.\n\n1.0 is the vanilla default and will cause the least issues").addAfterChangeCallback(@ (_newValue) speedSettingCallback());

		tacticalSpeedPage.addDivider("MiscDivider1");
	}

	{	// Fast
		tacticalSpeedPage.addTitle("TacticalSpeedTitleFast", "Fast Speed");

		tacticalSpeedPage.addRangeSetting("TacticalSpeed.Fast.VirtualClockMult", 2.0, 1.0, 8.0, 0.2, "Virtual Clock", "Multiplier for the virtual clock during tactical combat. \nIt affects movement speed and animation speed of characters and the delay between skill use.\n\n1.0 is the vanilla default and will cause the least issues").addAfterChangeCallback(@ (_newValue) speedSettingCallback());

		tacticalSpeedPage.addRangeSetting("TacticalSpeed.Fast.UISpeedMult", 2.0, 1.0, 4.0, 0.1, "UI Speed", "Multiplier for how fast the User Interface animates during combat. \nIt speeds up the Turn Sequence Bar, by lowering delays and durations related to it.\n\n1.0 is the vanilla default and will cause the least issues").addAfterChangeCallback(@ (_newValue) speedSettingCallback());

		tacticalSpeedPage.addDivider("MiscDivider2");
	}
}
