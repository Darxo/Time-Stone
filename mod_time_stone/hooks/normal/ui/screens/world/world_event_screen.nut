::TimeStone.HooksMod.hook("scripts/ui/screens/world/world_event_screen", function(q) {
	q.hide = @(__original) { function hide( _withSlideAnimation = false )
	{
		__original(_withSlideAnimation);

		::TimeStone.Interface.triggerEvent(::TimeStone.Const.Event.LeaveEventScreen);
	}}.hide;
});
