defmodule Heresys.Network.TCPPlayerServer do
  @moduledoc """
  Heresys TCP server
  """

  require Logger
  use GenServer
  use Heresys.Entity.Player

  def start_link(port), do: GenServer.start_link(__MODULE__, port, name: __MODULE__)

  @impl true
  def init(port) do
    Process.flag(:trap_exit, true)
    {:ok, socket} = :gen_tcp.listen(port, [:binary, :inet6, packet: :line, reuseaddr: true, active: true])
    Task.Supervisor.async(Heresys.Network.TaskSupervisor, fn -> accept_loop(socket) end)

    {:ok, socket}
  end

  defp accept_loop(socket) do
      {:ok, client} = :gen_tcp.accept(socket)
      {:ok, pid} = Player.new(client)
      :ok = :gen_tcp.controlling_process(client, pid)

    accept_loop(socket)
  end

  @impl true
  def terminate(:shutdown, socket) do
    :ok = :gen_tcp.close(socket)
    Logger.info("Shut down on #{Atom.to_string(__MODULE__)}")
  end
end
