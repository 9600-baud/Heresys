defmodule Heresys.Entity.Terminal do
  @moduledoc """
  Behaviour for Heresys entity terminals
  """

  require Logger

  @callback egress(data :: any, pid :: pid)  :: any
  @callback ingress(data :: any, pid :: pid) :: any

  def register(terminal) do
    uuid = UUID.uuid1()

   {:ok, _pid} = Registry.register(Heresys.Entity.Registry, uuid, terminal)
   Logger.debug("Registered entity with uuid #{uuid}")
  end
end
