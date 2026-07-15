::TimeStone.HooksMod.hook("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(q) {
	q.enableNormalTimeButton = @(__original) { function enableNormalTimeButton( _enabled )
	{
		// if (::TimeStone.Mod.ModSettings.getSetting("NeverDisableSpeedButtons").getValue())
		{
			return __original(true);
		}

		__original(_enabled);
	}}.enableNormalTimeButton;

	q.enableFastTimeButton = @(__original) { function enableFastTimeButton( _enabled )
	{
		// if (::TimeStone.Mod.ModSettings.getSetting("NeverDisableSpeedButtons").getValue())
		{
			return __original(true);
		}

		__original(_enabled);
	}}.enableFastTimeButton;

	q.enableVeryFastTimeButton = @(__original) { function enableVeryFastTimeButton( _enabled )
	{
		// if (::TimeStone.Mod.ModSettings.getSetting("NeverDisableSpeedButtons").getValue())
		{
			return __original(true);
		}

		__original(_enabled);
	}}.enableVeryFastTimeButton;
});
