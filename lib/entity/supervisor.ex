defmodule Heresys.Entity.Supervisor do
  @moduledoc """
  Supervisor for Heresys entity supervisor groups
  """

  use Supervisor

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok, name: Heresys.Entity.Supervisor)
  end

  def init(:ok) do
    children = [
      {Heresys.Entity.Player.Manager, []},
      {Registry, keys: :unique, name: Heresys.Entity.Registry},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
