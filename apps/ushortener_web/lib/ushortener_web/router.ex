defmodule UshortenerWeb.Router do
  use UshortenerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {UshortenerWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", UshortenerWeb do
    pipe_through :browser

    # get "/:short_code", LinkController, :show

    live "/", LinkLive, :index
  end
end
