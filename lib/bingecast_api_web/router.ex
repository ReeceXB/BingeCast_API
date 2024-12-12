defmodule BingecastApiWeb.Router do
  use BingecastApiWeb, :router
  use Pow.Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: BingecastApiWeb.APIAuthErrorHandler
  end

  # Define Pow routes in a separate scope without aliases
  scope "/api" do
    pipe_through :api

    pow_routes()
  end

  scope "/api", BingecastApiWeb do
    pipe_through [:api, :api_protected]

    resources "/posts", PostController, only: [:create]
  end

  scope "/api", BingecastApiWeb do
    pipe_through :api

    resources "/posts", PostController, only: [:index, :show]
  end

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BingecastApiWeb.Telemetry
    end
  end

  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
