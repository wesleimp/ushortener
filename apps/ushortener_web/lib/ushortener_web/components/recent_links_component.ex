defmodule UshortenerWeb.RecentLinksComponent do
  @moduledoc false

  use UshortenerWeb, :live_component

  def render(assigns) do
    ~L"""
    <section class="mt-4 bg-gray-100 rounded-md p-8 shadow-lg z-10">
      <h2 class="text-gray-800 font-bold tracking-wide text-lg">Recent short links:</h2>
      <ul class="overflow-y-hidden">
        <%= for link <- @recent do %>
          <li class="leading-8 py-2 float-left mr-4">
            <a class="p-2 text-black rounded-md bg-yellow-500 hover:bg-yellow-400 text-gray-200 shadow"
              href="/<%= link.short_code %>"
              target="_blank">
              <%= link.short_code %>
            </a>
          </li>
        <% end %>
      </ul>
    </section>
    """
  end
end
