defmodule Heresys.Shell.System do
  defstruct terminal: nil

  use GenServer
  alias __MODULE__ # Struct magic

  use Heresys.Shell

  def start_link({_terminal, _extra_args} = args), do: GenServer.start_link(__MODULE__, args)

  @impl true
  def init({terminal, _extra_args}) do

    {:ok, %System{ terminal: terminal }}
  end

  @impl true
  def egress(data, state) do
    IO.inspect(data)
    {:ok, state}
  end

  @impl true
  def ingress(data, state) do
    IO.inspect(data)
    {:ok, state}
  end
end
