// generate all msu related things. This should happen early because other parts of the code might expect these to be fetchable at an early point
::includeFiles(::IO.enumerateFiles("mod_time_stone/msu"));

::includeFiles(::IO.enumerateFiles("mod_time_stone/hooks"));		// This will load and execute all hooks
