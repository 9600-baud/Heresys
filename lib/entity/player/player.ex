defmodule Heresys.Entity.Player do
  @moduledoc """
  heresys player API
  """

  @behaviour Heresys.Entity

  alias Heresys.Entity.Player, as: Player

  defmacro __using__(_args) do
    quote do alias Heresys.Entity.Player, as: Player end
  end

  @doc """
  Sets up a new player with a terminal with its own shell stack
  """

  @impl true
  @spec new(socket :: port) :: {:ok, pid :: pid}
  def new(socket) do
    {:ok, supervisor} = Player.Manager.start_child(socket)
    {:ok, terminal}  = supervisor |> Player.Supervisor.get_terminal()
    IO.inspect(terminal)
    Heresys.Entity.Terminal.register(terminal)
    {:ok, terminal}
  end

  @impl true
  def ingress(pid, data), do: Player.Terminal.ingress(pid, data)

  @impl true
  def egress(pid, data), do: Player.Terminal.egress(pid, data)
end
