defmodule Heresys.Shell.Stack do

  use Agent

  def start_link(_args), do: Agent.start_link(fn _ -> [] end)

  def start_shell(pid, module, args \\ []) do
    # Y6777


  end
end
