defmodule DeviceManager.Discovery.SmartMeter do
  use DeviceManager.Discovery

  alias DeviceManager.Device.SmartMeter

  def init_handlers do
    Logger.info "Starting Raven"
    Raven.EventManager.add_handler(Discovery.SmartMeter.RavenSMCD)
  end

  def handle_info({:raven, %Raven.Meter.State{} = device}, state) do
    {:noreply, handle_device(device, state, SmartMeter.RavenSMCD)}
  end

  def handle_info({:raven, %Raven.Client.State{} = device}, state) do
    {:noreply, state}
  end

end
