::TimeStone.HooksMod.hook("scripts/states/world/asset_manager", function(q) {
// Private
	q.m.TS_LastSunrise <- 0;	// Last day at which we witnessed night turning into day
	q.m.TS_CanBecomeSunrise <- false;
	q.m.TS_LastNightfall <- 0;	// Last day at which we witnessed day turning into night
	q.m.TS_CanBecomeNightfall <- false;

	q.update = @(__original) { function update( _worldState )
	{
		if (::World.getTime().IsDaytime)
		{
			if (this.m.TS_CanBecomeSunrise && ::World.getTime().Days > this.m.TS_LastSunrise)
			{
				::TimeStone.WorldPause.triggerEvent(::TimeStone.Const.Event.Sunrise);
				this.m.TS_LastSunrise = ::World.getTime().Days;		// Sunrise can only trigger once per day
			}
			this.m.TS_CanBecomeSunrise = false;
			this.m.TS_CanBecomeNightfall = true;		// Nightfall can only happen after it has been day at least once
		}
		else
		{
			if (this.m.TS_CanBecomeNightfall && ::World.getTime().Days > this.m.TS_LastNightfall)
			{
				::TimeStone.WorldPause.triggerEvent(::TimeStone.Const.Event.Nightfall);
				this.m.TS_LastNightfall = ::World.getTime().Days;		// Nightfall can only trigger once per day
			}
			this.m.TS_CanBecomeSunrise = true;		// Sunrise can only happen after it has been night at least once
			this.m.TS_CanBecomeNightfall = false;
		}

		__original(_worldState);
	}}.update;
});
