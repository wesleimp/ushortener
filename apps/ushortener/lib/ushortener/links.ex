defmodule Ushortener.Links do
  @moduledoc false

  alias Ushortener.Links.Link
  alias Ushortener.Repo

  @doc """
  Gets a URL by short code
  """
  def get_by_short_code(short_code) do
    Link
    |> Repo.get_by(short_code: short_code)
  end

  @doc """
  Creates a new link
  """
  def create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end
end
