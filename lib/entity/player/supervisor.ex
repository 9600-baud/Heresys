defmodule Heresys.Entity.Player.Supervisor do

  use Supervisor
  use Heresys.Entity.Player
  use Heresys.Shell

  def start_link(socket) do
    Supervisor.start_link(__MODULE__, {:ok, socket})
  end

  @impl true
  def init({:ok, socket}) do
    children = [
      {Player.Register, fn -> [] end},
      {Player.Terminal, socket},
      {Shell.Supervisor, []},
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end

  def get_terminal(pid) do
    children = Supervisor.which_children(pid)

    {_module, terminal_pid, _type, _args} = Enum.find(
      children, {:error, :noterminal}, fn {module, _pid, _type, _args} ->
        module == Player.Terminal
    end)
    {:ok, terminal_pid}
  end
end
