defmodule Heresys do
  @moduledoc """
  Application module for Heresys (main supervisor)
  """

  use Application

  defmacro __using__(_args) do
    quote do alias Heresys, as: H end
  end

  def start(_type, _args) do
    children = [
      {Heresys.Entity.Supervisor,  name: Heresys.Entity.Supervisor},
      {Heresys.Network.Supervisor, name: Heresys.Network.Supervisor},
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end

  def hello() do
    {:world}
  end

end
