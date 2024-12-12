defmodule BingecastApi.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      BingecastApi.Repo,
      # Start the Telemetry supervisor
      BingecastApiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: BingecastApi.PubSub},
      # Start the Endpoint (http/https)
      BingecastApiWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: BingecastApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BingecastApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
