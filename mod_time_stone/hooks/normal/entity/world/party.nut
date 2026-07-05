::TimeStone.HooksMod.hook("scripts/entity/world/party", function(q) {
// Private
	q.m.TS_LastSeenByPlayer <- 0;	// ::Time.getVirtualTimeF() at which the player has last seen this unit
	q.m.TS_WasHidden <- false;		// Was this party hidden to the player in the last frame?

	q.onUpdate = @(__original) { function onUpdate()
	{
		if (::World.State.getPlayer().isAbleToSee(this))
		{
			if (this.m.TS_WasHidden && this.isAttackable() && ::Time.getVirtualTimeF() > this.m.TS_LastSeenByPlayer + ::TimeStone.Mod.ModSettings.getSetting("ForgetPartiesAfterXHours").getValue())
			{
				// Note that this currently has overlap with onDiscovered, at least for the first time
				// For triggering pause this is not a problem. But should we start playing sound effects, we might wanna disable the vanilla behavior
				if (this.isAlliedWithPlayer())
				{
					::TimeStone.Interface.triggerEvent(::TimeStone.Const.Event.DiscoverAlliesParty);
				}
				else
				{
					::TimeStone.Interface.triggerEvent(::TimeStone.Const.Event.DiscoverHostileParty);
				}
			}

			this.m.TS_WasHidden = false;
		}
		else
		{
			if (!this.m.TS_WasHidden) this.m.TS_LastSeenByPlayer = ::Time.getVirtualTimeF();
			this.m.TS_WasHidden = true;
		}

		__original();
	}}.onUpdate;
});
