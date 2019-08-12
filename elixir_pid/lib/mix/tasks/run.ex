defmodule Mix.Tasks.RunTask do
  use Mix.Task
  @shortdoc "calls ElixirPidExamples.filePid/1 and ElixirPidExamples.filePid/1 functions."
  def run(_) do
    ElixirPidExamples.filePid('hello') |> IO.inspect()
    ElixirPidExamples.file('hello') |> IO.inspect()
    from_the_docs()
    res = {ping, pong} = Table.start |> IO.inspect()
    send ping, {pong, :ping}
    receive do
      {_, _never_gets_reached}  -> "won't match"
    end
    # future plan: use self() for everything.
    # 1) instead of variables maintain state by sending to self using send and recieve
    # 2) use processes other to represent individual variables.
    # 3) optional: write a function to learn all modules that have been included into a process.
    # 4) does autocomplete work when using IEx and an agent is wrapped in a module?
    # 5) spawn, spawn_link, task, agent, genserver ... only concern yourself with extending the main process self().
  end

  @shortdoc "implementation of process examples from https://elixir-lang.org/getting-started/processes.html"
  def from_the_docs() do
    pid = spawn fn -> 1 + 2 end
    pid |> IO.inspect()
    Process.alive?(pid) |> IO.inspect()
    self() |> IO.inspect()
    Process.alive?(self()) |> IO.inspect()
    send self(), {:hello, "world"} |> IO.inspect()

    receive do
      {:hello, msg}  -> msg
      {:world, _msg} -> "won't match"
    after
      1_000 -> "nothing after 1s"
    end |> IO.inspect()

    parent = self() |> IO.inspect()
    spawn fn -> send(parent, {:hello, self()}) end |> IO.inspect()

    receive do
      {:hello, pid} -> "Got hello from #{inspect pid}"
    end |> IO.inspect()

    send self(), :hello |> IO.inspect()
  end
end
defmodule Table do
  def ping do
    receive do
      {from, :ping} ->
        IO.puts 'ping process reached, going to respond with :pong'
        :timer.sleep(1000)
        send from, {self(), :pong}
    end
    ping
  end

  def pong do #1
    receive do
      {from, :pong} -> #2
        IO.puts 'pong process reached, going to respond with :ping'
        :timer.sleep(1000) #4
        send from, {self(), :ping} #3
    end
    pong
  end

  def start do
    ping_pid = spawn __MODULE__, :ping, []
    pong_pid = spawn __MODULE__, :pong, [] #5
    {ping_pid, pong_pid}
  end
end
'''
  misc links:
  https://www.oreilly.com/learning/playing-with-processes
  https://hexdocs.pm/elixir/Process.html
  https://elixirschool.com/en/lessons/advanced/concurrency/
'''
