# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of Mix.Config.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
use Mix.Config

# Configure Mix tasks and generators
config :ushortener,
  ecto_repos: [Ushortener.Repo]

config :ushortener, Ushortener.Repo, migration_primary_key: [name: :id, type: :binary_id]

config :ushortener_web,
  ecto_repos: [Ushortener.Repo],
  generators: [context_app: :ushortener]

# Configures the endpoint
config :ushortener_web, UshortenerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xMoMpCrw4sJW7w7soLmQrD9SZDzCpjYy/cTsBj17duLoSua+WNCP9btwqzjNcdg1",
  render_errors: [view: UshortenerWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Ushortener.PubSub,
  live_view: [signing_salt: "9hzD5jch"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :libcluster,
  topologies: [
    local: [
      strategy: Cluster.Strategy.Gossip
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
