defmodule Ushortener.Repo do
  use Ecto.Repo,
    otp_app: :ushortener,
    adapter: Ecto.Adapters.Postgres
end
