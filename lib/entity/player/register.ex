defmodule Heresys.Entity.Player.Register do
  use Agent

  def start_link(_args), do: Agent.start_link(fn -> [] end)

end
