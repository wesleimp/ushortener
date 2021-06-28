defmodule UshortenerWeb.LinksController do
  @moduledoc false

  use UshortenerWeb, :controller

  alias Ushortener.Links
  alias Ushortener.Links.Link

  def show(conn, %{"short_code" => short_code} = _params) do
    case Links.get_by_short_code(short_code) do
      %Link{url: url} ->
        conn
        |> put_status(301)
        |> redirect(external: url)

      nil ->
        conn
        |> put_status(:not_found)
        |> put_view(UshortenerWeb.ErrorView)
        |> render(:not_found, conn.assigns)
        |> halt()
    end
  end
end
