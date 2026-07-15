::TimeStone.HooksMod.hook("scripts/entity/world/party", function(q) {
// Private
	// We don't serialize this, because we assume that after loading a game, the player has forgotton all discovered enemies already
	q.m.TS_LastSeenByPlayer <- 0;	// ::Time.getVirtualTimeF() at which the player has last seen this unit
	q.m.TS_WasHidden <- false;		// Was this party hidden to the player in the last frame?

	q.onUpdate = @(__original) { function onUpdate()
	{
		__original();

		if (::World.State.getPlayer().isAbleToSee(this))
		{
			if (this.m.TS_WasHidden && this.isAttackable() && ::Time.getVirtualTimeF() > this.m.TS_LastSeenByPlayer + ::TimeStone.Mod.ModSettings.getSetting("ForgetPartiesAfterXHours").getValue())
			{
				if (this.isAlliedWithPlayer())
				{
					::TimeStone.WorldPause.triggerEvent(::TimeStone.Const.Event.DiscoverAlliedParty);
				}
				else
				{
					::TimeStone.WorldPause.triggerEvent(::TimeStone.Const.Event.DiscoverHostileParty);
				}
			}

			this.m.TS_WasHidden = false;
		}
		else
		{
			if (!this.m.TS_WasHidden) this.m.TS_LastSeenByPlayer = ::Time.getVirtualTimeF();
			this.m.TS_WasHidden = true;
		}
	}}.onUpdate;
});
