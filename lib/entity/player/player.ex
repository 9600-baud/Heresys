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
  def new(socket) do
    {:ok, supervisor} = Player.Manager.start_child()
    {:ok, terminal}   = Player.Supervisor.start_child(supervisor, Player.Terminal, {supervisor, socket})
    {:ok, _pid} = Player.Terminal.start_shell(terminal, Heresys.Shell.System, [])
    {:ok, terminal}
  end

  @impl true
  def ingress(pid, data), do: Player.Terminal.ingress(pid, data)

  @impl true
  def egress(pid, data), do: Player.Terminal.egress(pid, data)

  def start_shell(pid, module, args \\ []), do: Player.Terminal.start_shell(pid, module, args)
end
