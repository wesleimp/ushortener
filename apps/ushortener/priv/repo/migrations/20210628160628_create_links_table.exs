defmodule Ushortener.Repo.Migrations.CreateLinksTable do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :url, :string
      add :short_code, :string

      timestamps()
    end

    create unique_index(:links, [:short_code])
  end
end
