defmodule Heresys.Entity.Player.Manager do
  @moduledoc """
  Supervisor for Player supervisors
  """

  use DynamicSupervisor
  use Heresys.Entity.Player

  def start_link(_args) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: Heresys.Entity.Player.Manager)
  end

  @impl true
  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_child(args) do
    spec = {Player.Supervisor, args}
    DynamicSupervisor.start_child(__MODULE__, spec)
  end
end
