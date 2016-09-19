defmodule DeviceManager.Consumer do
  alias Experimental.{GenStage}

  use GenStage

  def start_link() do
    GenStage.start_link(__MODULE__, :ok)
  end

  # Callbacks

  def init(:ok) do
    # Starts a permanent subscription to the broadcaster
    # which will automatically start requesting items.
    {:consumer, :ok, subscribe_to: [DeviceManager.Broadcaster]}
  end

  def handle_events(events, _from, state) do
    for event <- events do
      IO.inspect {self(), event}
    end
    {:noreply, [], state}
  end
end
