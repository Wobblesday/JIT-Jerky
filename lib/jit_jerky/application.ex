defmodule JITJerky.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      JITJerky.Repo,
      # Start the Telemetry supervisor
      JITJerkyWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: JITJerky.PubSub},
      # Start the Endpoint (http/https)
      JITJerkyWeb.Endpoint
      # Start a worker by calling: JITJerky.Worker.start_link(arg)
      # {JITJerky.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: JITJerky.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    JITJerkyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
