# elixir_pid
The pid of a process is very important for parallelism in elixir. Make a default catch all pid. #Explore.

## Sales Pitch
One of the big sellings about elixir the erlang virtual machine which uses very lightweight processes and dynamic process size allocation. However, the common programs that I write often are within the self() process.

My goal with this project is to move to multi-process by default when I program in elixir.

My goal with this project is to add more recieve commands in the self() process and have spawned processes that perform work in an async manner.

1) Spinning new processes in Elixir is easy
2) Realize your always on a process called self()
3) There are processes that came before the self() process which I often do not care about.
4) You can spawn new processes from the self process. 
5) You can spawn a process that spawns another process.



## Rough plan for this project:

1) mix task defines a bunch of recieve conditions to match communication for other processes
2) spawn processes to do a bunch of work. maybe counting to 5 million.
3) count so high the process fails and sends the last good state back to the self() process.
4) 
5)

## Max out some elixir data:
![Max out some elixir data](https://user-images.githubusercontent.com/11463275/63184613-b97fe380-c025-11e9-96bb-9986fec958fd.png)
https://stackoverflow.com/questions/28093580/how-to-get-minimum-and-maximum-value-of-each-type-in-elixir

## Collection of topics similar to this project:
https://youtu.be/WvYtaVW4ACo?t=2343
