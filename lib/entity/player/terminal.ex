defmodule Heresys.Entity.Player.Terminal do

  use GenServer
  use Heresys

  @behaviour H.Entity.Terminal

  def start_link(socket), do: GenServer.start_link(__MODULE__, {:ok, socket})

  @impl true
  def init({:ok, socket}) do

    state = %{
      socket: socket
    }

    {:ok, state}
  end

  @impl true
  def egress(_pid, _data) do

  end

  @impl true
  def ingress(data, pid),do: GenServer.cast(pid, {:ingress, data})

  defp _ingress(data, _state) do
    IO.inspect(data)
    # TODO
  end

  @impl true
  def handle_cast({:ingress, data}, state) do
     _ingress(data, state)
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

    {:ok, state}
  end
end
