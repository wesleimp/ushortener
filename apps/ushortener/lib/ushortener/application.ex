defmodule Ushortener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @topologies Application.compile_env(:libcluster, :topologies)

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [@topologies, [name: Ushortener.ClusterSupervisor]]},
      Ushortener.Repo,
      {Phoenix.PubSub, name: Ushortener.PubSub, adapter: Phoenix.PubSub.PG2}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Ushortener.Supervisor)
  end
end
