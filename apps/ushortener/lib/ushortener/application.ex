defmodule Ushortener.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Ushortener.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Ushortener.PubSub}
      # Start a worker by calling: Ushortener.Worker.start_link(arg)
      # {Ushortener.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Ushortener.Supervisor)
  end
end
