defmodule DeviceManager.Discovery do
  use GenServer
  require Logger
  alias DeviceManager.Discovery

  defmodule State do
    defstruct devices: []
  end

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def handle_device(device_state, module) do
    GenServer.call(__MODULE__, {:device, device_state, module})
  end

  def register_device(module) do
    GenServer.call(__MODULE__, {:register, module})
  end

  def init(:ok) do
    Process.flag(:trap_exit, true)
    {:ok, %State{}}
  end

  def handle_info({:EXIT, crashed, reason}, state) do
    Logger.info("Process #{inspect crashed} crashed: #{inspect reason} Current State: #{inspect state}")
    devices =
      Enum.filter(state.devices, fn {pid, device} ->
        case pid do
          ^crashed ->
            Logger.info "Removing #{inspect crashed} = #{inspect pid}"
            false
          _ -> true
        end
      end)
    {:noreply, %State{ state | devices: devices} }
  end

  def handle_call({:register, module}, _from, state) do
    module.start_link
    {:reply, :ok, state}
  end

  def handle_call({:device, device_state, module}, _from, state) do
    id = module.get_id(device_state)
    state =
      case Enum.any?(state.devices, fn({pid, device}) -> device.interface_pid == id end) do
        false ->
          Logger.info("Got Device - #{id} :: #{inspect device_state}")
          pid =
            case module.start_link(id, device_state) do
              {:error, {:already_started, pid}} -> pid
              {:ok, pid} -> pid
            end
          %State{state | devices: [{pid, module.device(pid)} | state.devices]}
        true ->
          Logger.debug("Updating State - #{id} #{inspect device_state}")
          %DeviceManager.Device{
            module.device(id) | state: module.update_state(id, device_state)
          } |> DeviceManager.Client.dispatch
          state
      end
    {:reply, :ok, state}
  end

end
