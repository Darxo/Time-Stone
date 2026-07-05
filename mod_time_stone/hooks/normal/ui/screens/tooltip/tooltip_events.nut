::TimeStone.HooksMod.hook("scripts/ui/screens/tooltip/tooltip_events", function(q) {
	q.general_queryUIElementTooltipData = @(__original) { function general_queryUIElementTooltipData( _entityId, _elementId, _elementOwner )
	{
		local ret = __original(_entityId, _elementId, _elementOwner);

		// Feat: We display the current speed multiplier on each vanilla speed button
		switch (_elementId)
		{
			// Todo: improve size/contract? Maybe move mult into title?
			case "world-screen.topbar.TimeNormalButton":
				ret[1].text += "\n\nSpeed Multiplier: " + ::MSU.Text.colorPositive(::Const.World.SpeedSettings.NormalMult.tofloat());
				break;
			case "world-screen.topbar.TimeFastButton":
				ret[1].text += "\n\nSpeed Multiplier: " + ::MSU.Text.colorPositive(::Const.World.SpeedSettings.FastMult.tofloat());
				break;
			case "world-screen.topbar.TimeVeryFastButton":
				ret[1].text += "\n\nSpeed Multiplier: " + ::MSU.Text.colorPositive(::Const.World.SpeedSettings.VeryFastMult.tofloat());
				break;
		}

		return ret;
	}}.general_queryUIElementTooltipData;
});
