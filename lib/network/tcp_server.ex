defmodule Heresys.Network.TCPServer do
  @moduledoc """
  Heresys TCP server
  """

  require Logger
  use Task
  use Heresys.Entity.Player

  def start_link(port) do
    {:ok, socket} = :gen_tcp.listen(port, [:binary, :inet6, packet: :line])

    Logger.info("Listening for connections on port #{port}")
    Task.start_link(__MODULE__, :run, [socket])
  end

  def run(socket) do
    Process.register(self(), Heresys.Network.TCPServer)
    accept_loop(socket)
  end

  defp accept_loop(socket) do
    #Task.Supervisor.async(Heresys.Network.TaskSupervisor, fn ->
      {:ok, client} = :gen_tcp.accept(socket)
      {:ok, pid} = Player.new(client)
      :ok = :gen_tcp.controlling_process(client, pid)
    #end)

    accept_loop(socket)
  end
end
