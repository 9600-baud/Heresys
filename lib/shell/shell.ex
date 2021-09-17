defmodule Heresys.Shell do
  @moduledoc """
  Behaviour for Heresys shells
  """

  defmacro __using__(_args) do
    quote do
      @behaviour Heresys.Shell

      def handle_call({:egress, data}, _from, state) do
        {result, state} = egress(data, state)
        {:reply, result, state}
      end

      def handle_call({:ingress, data}, _from, state) do
        {result, state} = ingress(data, state)
        {:reply, result, state}
      end
    end
  end

  @callback egress(data :: any, state :: any)  :: any
  @callback ingress(data :: any, state :: any) :: any

  def egress(pid, data), do: GenServer.call(pid, {:egress, data})
  def ingress(pid, data), do: GenServer.call(pid, {:ingress, data})
end
