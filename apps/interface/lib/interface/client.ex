defmodule Interface.Client do
  use GenServer
  require Logger
  alias NetworkManager.State, as: NM
  alias NetworkManager.Interface, as: NMInterface

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    NetworkManager.register
    Mdns.Server.add_service(%Mdns.Server.Service{
      domain: "rosetta.local",
      data: :ip,
      ttl: 120,
      type: :a
    })
    {:ok, %{}}
  end

  def handle_info(%NM{interface: %NMInterface{settings: %{ipv4_address: address}, status: %{operstate: :up}}}, state) do
    Logger.info "mDNS IP Set: #{inspect address}"
    Mdns.Server.set_ip(address)
    Mdns.Server.start
    {:noreply, state}
  end

  def handle_info(%NM{}, state) do
    {:noreply, state}
  end

  def handle_info(mes, state) do
    {:noreply, state}
  end

  def handle_call(:register, {pid, _ref}, state) do
    Registry.register(EventManager.Registry, Interface, pid)
    {:reply, :ok, state}
  end

  def dispatch(event) do
    EventManager.dispatch(Interface, event)
  end

end
