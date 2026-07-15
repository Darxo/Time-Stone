::TimeStone.HooksMod.hook("scripts/states/world_state", function(q) {
// Private
	q.m.TS_LastUniqueLocationDiscoveredSoundTime <- 0.0;
	q.m.TS_UniqueLocationDiscoveredOnWorldmap <- [
		"sounds/world/ts_fanfare_announcement_01.wav",
		"sounds/world/ts_fanfare_announcement_02.wav",
	];

	q.setPause = @(__original) { function setPause( _pauseGame )
	{
		if (this.m.IsGamePaused && !_pauseGame)		// Something tries to unpause the game
		{
			if (::TimeStone.WorldPause.isUnpauseProtected())
			{
				::World.TopbarDayTimeModule.TS_shakePauseButton();
				return;
			}
		}

		__original(_pauseGame);
	}}.setPause;

	q.onUpdate = @(__original) { function onUpdate()
	{
		if (::TimeStone.WorldPause.hasPendingAutoPause())
		{
			::TimeStone.WorldPause.executeAutoPause();
		}

		__original();
	}}.onUpdate;

// New Functions
	// Play the sound effect for discovering a unique location on the world map
	// Make sure, that this sound effect is not played too quickly in succession (e.g. when revealing the whole map at once)
	// This function has a similar structure to the vanilla "world_state::playEnemyDiscoveredSound()" one
	q.TS_playUniqueLocationDiscoveredSound <- function()
	{
		if (this.m.TS_LastUniqueLocationDiscoveredSoundTime + 8.0 < ::Time.getRealTimeF())
		{
			this.m.TS_LastUniqueLocationDiscoveredSoundTime = ::Time.getRealTimeF();
			::Sound.play(::MSU.Array.rand(this.m.TS_UniqueLocationDiscoveredOnWorldmap), 2.5);	// These sfx ended up being pretty quiet, so we boost their volume here
		}
	}
});
