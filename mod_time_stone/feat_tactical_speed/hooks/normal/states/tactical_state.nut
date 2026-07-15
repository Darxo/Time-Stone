::TimeStone.HooksMod.hook("scripts/states/tactical_state", function(q) {
	// Overwrite, because we greatly reduce the custom delay enforced by this
	q.setPause = @(__original) { function setPause( _bool )
	{
		__original(_bool);

		if (!_bool) ::TimeStone.TacticalSpeed.onUnpause();
	}}.setPause;
});
