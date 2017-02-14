defmodule EventManager.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(EventManager.Broadcaster, []),
    ]

    opts = [strategy: :one_for_one, name: EventManager.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
