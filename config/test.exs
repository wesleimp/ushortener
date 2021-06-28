use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :ushortener, Ushortener.Repo,
  username: System.get_env("USHORTENER_DATABASE_USERNAME", "postgres"),
  password: System.get_env("USHORTENER_DATABASE_PASSWORD", "postgres"),
  database: "ushortener_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: System.get_env("USHORTENER_DATABASE_HOSTNAME", "db"),
  port: System.get_env("USHORTENER_DATABASE_PORT", "5432"),
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ushortener_web, UshortenerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
