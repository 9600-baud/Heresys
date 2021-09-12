defmodule Heresys.Entity do
  @moduledoc """
  Behaviour for Heresys entities
  """

  @callback new(args :: any | nil) :: any

  @callback egress(data :: any, pid :: any) :: any
  @callback ingress(data :: any, pid :: any) :: any

end
