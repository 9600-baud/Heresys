defmodule Heresys.Entity.Player.Terminal do
  defstruct socket: nil, head: nil, head_old: nil, supervisor: nil

  require Logger
  use GenServer
  use Heresys
  use Heresys.Entity.Player

  @behaviour H.Entity.Terminal
  alias __MODULE__ # Magic

  def start_link({supervisor, socket}), do: GenServer.start_link(__MODULE__, {supervisor, socket})

  @impl true
  def init({supervisor, socket}) do
    Process.flag(:trap_exit, true)

    state = %Terminal{
      supervisor: supervisor,
      socket:     socket,
      head:       nil,
      head_old:  nil,
    }

    #{:ok, _pid} = _start_shell(Heresys.Shell.System, {self(), []}, state)
    {:ok, state}
  end

  def start_shell(pid, module, args), do: GenServer.call(pid, {:start_shell, module, args})

  @impl true
  def egress(pid, data), do: GenServer.cast(pid, {:egress, data})

  @impl true
  def ingress(data, pid),do: GenServer.cast(pid, {:ingress, data})

  defp _ingress(data, state), do: Heresys.Shell.ingress(state.head, data)

  @impl true
  def handle_cast({:ingress, data}, state) do
     _ingress(data, state)
     {:noreply, state}
  end

  def handle_cast({:egress, _data}, state) do

    {:noreply, state}
  end

  @impl true
  def handle_info({:tcp, _socket, data}, state) do
    _ingress(data, state)
    {:noreply, state}
  end

  @impl true
  def handle_info({:tcp_error, _socket}, state) do

    {:noreply, state}
  end

  @impl true
  def handle_info({:tcp_closed, _socket}, state) do
    :ok = Supervisor.stop(state.supervisor, :shutdown)
    {:ok, state}
  end

  @impl true
  def handle_info({:EXIT, pid, reason}, state) do
    Logger.debug("shell exit: #{IO.inspect(pid)}, #{IO.inspect(reason)}")
    {:noreply, state}
  end

  @impl true
  def handle_call({:start_shell, module, args}, _from, state) do
    {:ok, pid} = Player.Supervisor.start_child(state.supervisor, module, {self(), args})
    Process.monitor(pid)
    {:reply, {:ok, pid}, %{ state | head: pid, head_old: state.head}}
  end

  @impl true
  def terminate(:shutdown, state) do
    :ok = :gen_tcp.close(state.socket)
    :ok = Supervisor.stop(state.supervisor, :shutdown)
  end
end
