// generate all msu related things. This should happen early because other parts of the code might expect these to be fetchable at an early point
::includeFiles(::IO.enumerateFiles("mod_time_stone/feat_tactical_speed"));
::includeFiles(::IO.enumerateFiles("mod_time_stone/feat_world_pause"));
::includeFiles(::IO.enumerateFiles("mod_time_stone/feat_world_speed"));
