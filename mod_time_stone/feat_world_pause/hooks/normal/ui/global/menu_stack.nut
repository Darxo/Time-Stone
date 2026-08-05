::TimeStone.HooksMod.hook("scripts/ui/global/menu_stack", function(q) {
	q.pop = @(__original) { function pop( _ignoreValidator = false )
	{
		local ret = __original(_ignoreValidator);

		if (this.m.Stack != null && this.m.Stack.len() == 0)	// Last UI screen was closed
		{
			::TimeStone.WorldPause.triggerEvent(::TimeStone.Const.Event.LeaveUIScreen);
		}

		return ret;
	}}.pop;
});
