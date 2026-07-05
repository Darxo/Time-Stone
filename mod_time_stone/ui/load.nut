::Hooks.registerJS("ui/mods/mod_time_stone/setup.js");

foreach (file in ::IO.enumerateFiles("ui/mods/mod_time_stone/js_hooks"))
{
	::Hooks.registerJS(file + ".js");
}
