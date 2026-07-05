::TimeStone <- {
	ID = "mod_time_stone",
	Name = "Time Stone",
	Version = "0.1.0",
	GitHubURL = "https://github.com/Darxo/Time-Stone",
}

::TimeStone.HooksMod <- ::Hooks.register(::TimeStone.ID, ::TimeStone.Version, ::TimeStone.Name);
::TimeStone.HooksMod.require(["mod_msu"]);

::TimeStone.HooksMod.queue(">mod_msu", function() {
	::TimeStone.Mod <- ::MSU.Class.Mod(::TimeStone.ID, ::TimeStone.Version, ::TimeStone.Name);

	::TimeStone.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, ::TimeStone.GitHubURL);
	::TimeStone.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

	::include("mod_time_stone/load");		// Load mod adjustments and other hooks
	::include("mod_time_stone/ui/load");	// Load JS Adjustments and Hooks
});
