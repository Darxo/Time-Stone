::TimeStone.HooksMod.hook("scripts/entity/world/location", function(q) {
// Private
	q.m.TS_LastSeenByPlayer <- 0;	// ::Time.getVirtualTimeF() at which the player has last seen this unit
	q.m.TS_WasHidden <- false;		// Was this party hidden to the player in the last frame?

	q.onDiscovered = @(__original) { function onDiscovered()
	{
		if (this.isLocationType(::Const.World.LocationType.Unique))
		{
			::TimeStone.Interface.triggerEvent(::TimeStone.Const.Event.DiscoverUniqueLocation);
		}

		if (this.isAttackable() && !this.isAlliedWithPlayer())
		{
			::TimeStone.Interface.triggerEvent(::TimeStone.Const.Event.DiscoverHostileAttackableLocation);
		}

		__original();
	}}.onDiscovered;
});
