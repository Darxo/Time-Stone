::TimeStone.Mod.Keybinds.addSQKeybind("TacticalSpeed.Normal", "f2", ::MSU.Key.State.Tactical, function() {
	::TimeStone.TacticalSpeed.triggerAction(::TimeStone.Const.SpeedAction.SetNormal);
}, "Normal Speed");

::TimeStone.Mod.Keybinds.addSQKeybind("TacticalSpeed.Fast", "f3", ::MSU.Key.State.Tactical, function() {
	::TimeStone.TacticalSpeed.triggerAction(::TimeStone.Const.SpeedAction.SetFast);
}, "Fast Speed");
