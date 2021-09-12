defmodule Heresys.Network.Supervisor do
  @moduledoc """
  Supervisor for Heresys network handlers
  """

  use Supervisor

  def start_link(_args), do: Supervisor.start_link(__MODULE__, :ok)

  @impl true
  def init(:ok) do
    children = [
      {Task.Supervisor, name: Heresys.Network.TaskSupervisor},
      {Heresys.Network.TCPServer, 9001},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
