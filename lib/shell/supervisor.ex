defmodule Heresys.Shell.Supervisor do
  @moduledoc """
  Supervisor for Heresys shells
  """

  use DynamicSupervisor

  def start_link(_args), do: DynamicSupervisor.start_link(__MODULE__, :ok)

  @impl true
  def init(:ok), do: DynamicSupervisor.init(strategy: :one_for_one)

  def start_child(pid, shell_module, args \\ []) do
    spec = {shell_module, args}
    DynamicSupervisor.start_child(pid, spec)
  end
end
