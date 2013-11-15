The "shell" version of parallelizing the MINE job.

This simply spawns a process for each combination of variables,
up to a limit specified by the user (default 2).

Each process uses command line arguments to the MINE command to specify
the columns to be compared.

This has built in inefficiencies. To wit, a Java process is created
for each combination of variables, and the MINE.jar as supplied by
Reshef et al will read the entire file into each process. In practice,
these are small issues on a modern multi-core machine.


After testing, I have discovered that the version of MINE distributed with
the 2011 paper (Reshef et al) does not support the argument I was counting
on to spawn multiple processes. "-onePair" is noted in the documentation,
but it not recognized in practice. In eery other way, the shell script
seems ready. It appears I will have to implement the algorithm on my own
to support multi-threading and multi-processing.

