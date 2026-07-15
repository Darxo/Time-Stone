{	// World Speed
	local worldSpeedPage = ::TimeStone.Mod.ModSettings.addPage("World Speed");

	{	// Vanilla Mults
		worldSpeedPage.addRangeSetting("SpeedSettingsNormalMult", ::Const.World.SpeedSettings.NormalMult, 1.0, 4.0, 0.1, "Normal Speed", "Normal World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.NormalMult = _newValue);

		worldSpeedPage.addRangeSetting("SpeedSettingsFastMult", ::Const.World.SpeedSettings.FastMult, 1.0, 8.0, 0.2, "Fast Speed", "Fast World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.FastMult = _newValue);

		worldSpeedPage.addRangeSetting("SpeedSettingsVeryFastMult", 4.0, 1.0, 16.0, 0.5, "Very Fast Speed", "Very Fast World Speed.").addBeforeChangeCallback(@ (_newValue) ::Const.World.SpeedSettings.VeryFastMult = _newValue);
	}
}
