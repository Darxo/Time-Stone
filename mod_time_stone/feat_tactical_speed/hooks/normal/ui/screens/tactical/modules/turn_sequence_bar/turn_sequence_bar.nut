::TimeStone.HooksMod.hook("scripts/ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function(q) {
// New Functions
	/// Cause the js part to scale durations and delays for the turn sequence bar
	q.TS_applyDurationMultiplier <- function( _mult )
	{
		this.m.JSHandle.call("TS_applyDurationMultiplier", _mult);
	}
});
