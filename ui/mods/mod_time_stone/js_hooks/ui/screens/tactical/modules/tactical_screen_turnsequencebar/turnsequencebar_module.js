TimeStone.Hooks.TacticalScreenTurnSequenceBarModule_createDIV = TacticalScreenTurnSequenceBarModule.prototype.createDIV;
TacticalScreenTurnSequenceBarModule.prototype.createDIV = function( _parentDiv )
{
	TimeStone.Hooks.TacticalScreenTurnSequenceBarModule_createDIV.call(this, _parentDiv);

	// We save the vanilla duration and delay values
	var originalDurations = {
		FadeInDuration: this.mFadeInDuration,
		FadeOutDuration: this.mFadeOutDuration,
		FadeOutDurationIfHiddenToPlayer: this.mFadeOutDurationIfHiddenToPlayer,
		SlideInDuration: this.mSlideInDuration,
		SlideOutDuration: this.mSlideOutDuration,
		SlideOutDurationIfHiddenToPlayer: this.mSlideOutDurationIfHiddenToPlayer,
		ResizeFirstSlotTime: this.mResizeFirstSlotTime,

		// We skip over this value, because it is already very short. Making it shorter causes a bug where entities moving in the first slot sometimes visually vanishing
		// ResizeFirstSlotTimeIfPreviousWasHiddenToPlayer: this.mResizeFirstSlotTimeIfPreviousWasHiddenToPlayer,
		ResizeFirstSlotImageTime: this.mResizeFirstSlotImageTime,
		SelectionFadeInDuration: this.mSelectionFadeInDuration,
		SelectionFadeOutDuration: this.mSelectionFadeOutDuration,
		ProgressbarMovementDuration: this.mProgressbarMovementDuration,
		SkillPreviewFadeIn: this.mSkillPreviewFadeIn,
		SkillPreviewFadeOut: this.mSkillPreviewFadeOut,
		StatsPanelFadeInTime: this.mStatsPanelFadeInTime,
		StatsPanelFadeOutTime: this.mStatsPanelFadeOutTime,
	}

	this.mTS_OriginalDurations = originalDurations;
}

// New Functions
{
	/// Scale all original vanilla duration values with _mult
	TacticalScreenTurnSequenceBarModule.prototype.TS_applyDurationMultiplier = function( _mult )
	{
		// A simple for loop works because currently all variables are durations and react the same way to a multiplier
		for (var key in this.mTS_OriginalDurations)
		{
			this["m" + key] = this.mTS_OriginalDurations[key] * _mult;
		}
	}
}
