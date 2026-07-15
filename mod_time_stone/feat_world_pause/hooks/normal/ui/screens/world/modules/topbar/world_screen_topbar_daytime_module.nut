::TimeStone.HooksMod.hook("scripts/ui/screens/world/modules/topbar/world_screen_topbar_daytime_module", function(q) {
// New Functions
	q.TS_shakePauseButton <- function()
	{
		this.m.JSHandle.asyncCall("TS_shakePauseButton", null);
	}
});
