::TimeStone.HooksMod.hook("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(q) {
	q.enableNormalTimeButton = @(__original) { function enableNormalTimeButton( _enabled )
	{
		return __original(true);
	}}.enableNormalTimeButton;

	q.enableFastTimeButton = @(__original) { function enableFastTimeButton( _enabled )
	{
		return __original(true);
	}}.enableFastTimeButton;

	q.enableVeryFastTimeButton = @(__original) { function enableVeryFastTimeButton( _enabled )
	{
		return __original(true);
	}}.enableVeryFastTimeButton;

// New Functions
	q.TS_shakePauseButton <- function()
	{
		this.m.JSHandle.asyncCall("TS_shakePauseButton", null);
	}
});
