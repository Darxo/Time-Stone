::TimeStone.HooksMod.hook("scripts/states/world_state", function(q) {
// Private
	q.m.TS_LastUniqueLocationDiscoveredSoundTime <- 0.0;
	q.m.TS_UniqueLocationDiscoveredOnWorldmap <- [
		"sounds/world/ts_fanfare_announcement_01.wav",
		"sounds/world/ts_fanfare_announcement_02.wav",
	];

	q.onInit = @(__original) { function onInit()
	{
		__original();

		// We no longer support this value and therefore set it to 0.0
		this.m.MinWorldSpeedMult = 0.0;
	}}.onInit;

	q.setPause = @(__original) { function setPause( _pauseGame )
	{
		if (this.m.IsGamePaused && !_pauseGame)		// Something tries to unpause the game
		{
			if (::TimeStone.Interface.isUnpauseProtected())
			{
				::World.TopbarDayTimeModule.TS_shakePauseButton();
				return;
			}
		}

		__original(_pauseGame);
	}}.setPause;

	q.setNormalTime = @(__original) { function setNormalTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setNormalTime;

	q.setFastTime = @(__original) { function setFastTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setFastTime;

	q.setVeryFastTime = @(__original) { function setVeryFastTime( _force = false )
	{
		// Feat: We now always force this time through to allow the player to adjust time during camping or escorting
		__original(true);
	}}.setVeryFastTime;

	q.setMinWorldSpeedMult = @(__original) { function setMinWorldSpeedMult( _value )
	{
		// We no longer support this value and therefore set it to 0.0
		__original(0.0);
	}}.setMinWorldSpeedMult;

	q.onUpdate = @(__original) { function onUpdate()
	{
		if (::TimeStone.Interface.hasPendingAutoPause())
		{
			::TimeStone.Interface.executeAutoPause();
		}

		__original();
	}}.onUpdate;

	q.updateTopBarButtonState = @(__original) { function updateTopBarButtonState()
	{
		if (!::MSU.isNull(::World.TopbarDayTimeModule))
		{
			// We make sure all time buttons are enabled
			::World.TopbarDayTimeModule.enableNormalTimeButton(true);
			::World.TopbarDayTimeModule.enableFastTimeButton(true);
			::World.TopbarDayTimeModule.enableVeryFastTimeButton(true);

			// Then we replicate the vanilla code for
			if (this.isPaused())
			{
				::World.TopbarDayTimeModule.updateTimeButtons(0);
			}
			else
			{
				switch (::World.getSpeedMult())
				{
					case ::Const.World.SpeedSettings.NormalMult:
						::World.TopbarDayTimeModule.updateTimeButtons(1);
						break;
					case ::Const.World.SpeedSettings.FastMult:
						::World.TopbarDayTimeModule.updateTimeButtons(2);
						break;
					case ::Const.World.SpeedSettings.VeryFastMult:
						::World.TopbarDayTimeModule.updateTimeButtons(3);
						break;
					default:
						// If there is currently a custom speed multiplier, we disable all
						::World.TopbarDayTimeModule.updateTimeButtons(-1);
				}
			}

			return;
		}

		__original();
	}}.updateTopBarButtonState;

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
