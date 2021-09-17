defmodule Heresys.Entity.Player.Supervisor do

  use Supervisor, restart: :transient
  use Heresys.Entity.Player

  def start_link(args \\ []) do
    Supervisor.start_link(__MODULE__, args)
  end

  @impl true
  def init(_args) do
    children = []

    Supervisor.init(children, strategy: :rest_for_one)
  end

  def start_child(pid, module, args) do
    spec = {module, args}
    {:ok, _pid} = Supervisor.start_child(pid, spec)
  end
end
