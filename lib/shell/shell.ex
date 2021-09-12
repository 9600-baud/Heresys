defmodule Heresys.Shell do
  @moduledoc """
  Behaviour for Heresys shells
  """

  defmacro __using__(_args) do
    quote do alias Heresys.Shell, as: Shell end
  end

  @callback egress(pid :: pid, data :: any)  :: any
  @callback ingress(pid :: pid, data :: any) :: any
end
