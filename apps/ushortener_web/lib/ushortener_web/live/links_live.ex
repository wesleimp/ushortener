defmodule UshortenerWeb.LinksLive do
  use UshortenerWeb, :live_view

  alias Ushortener.Links
  alias Ushortener.Links.Link

  @recent_links 10

  @impl true
  def mount(_params, _session, socket) do
    pubsub_subscribe(socket)

    recent_links = Links.list_recent(@recent_links)

    socket =
      assign(socket,
        url: "",
        short_url: "",
        recent: [],
        url_valid?: nil,
        recent: recent_links
      )

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    UshortenerWeb.LinksView.render("index.html", assigns)
  end

  @impl true
  def handle_event("shorten_url", %{"url" => url}, socket) do
    case shorten(url) do
      {:ok, %Link{short_code: short_code}} ->
        short_url = Routes.links_url(UshortenerWeb.Endpoint, :show, short_code)

        {:noreply, assign(socket, %{short_url: short_url, url: "", url_valid?: nil})}

      _ ->
        {:noreply, put_flash(socket, :error, "There was an error creating your short link")}
    end
  end

  @impl true
  def handle_event("validate_url", %{"url" => url}, socket) do
    if Link.url_valid?(url) do
      {:noreply, assign(socket, url_valid?: true)}
    else
      {:noreply, assign(socket, url_valid?: false)}
    end
  end

  @impl true
  def handle_info({:created, link}, socket) do
    {:noreply,
     update(socket, :recent, fn recents ->
       build_recent_list(link, recents)
     end)}
  end

  defp pubsub_subscribe(socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(Ushortener.PubSub, "links")
    end
  end

  defp shorten(url) do
    short_code = Link.generate_short_code()

    Links.create_link(%{
      url: url,
      short_code: short_code
    })
  end

  defp build_recent_list(link, recents) do
    [link]
    |> Kernel.++(recents)
    |> Enum.take(@recent_links)
  end
end
