# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jit_jerky,
  namespace: JITJerky,
  ecto_repos: [JITJerky.Repo]

# Configures the endpoint
config :jit_jerky, JITJerkyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/QkR1I1+HsSEMLWrqT+IWbLr02m9ubN2EyLpnnvZwTeLsF4HCtM5jAXTNvRO/efC",
  render_errors: [view: JITJerkyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: JITJerky.PubSub,
  live_view: [signing_salt: "TVuehc5j"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
