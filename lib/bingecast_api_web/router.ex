defmodule BingecastApiWeb.Router do
  use BingecastApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug BingecastApiWeb.APIAuthPlug, otp_app: :bingecast_api
  end

  pipeline :api_protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: BingecastApiWeb.APIAuthErrorHandler
  end

  # Protected posts
  scope "/api", BingecastApiWeb do
    pipe_through [:api, :api_protected]

    resources "/my-posts", MyPostController, only: [:index, :create]
  end

  # Public routes
  scope "/api", BingecastApiWeb do
    pipe_through :api

    resources "/registration", RegistrationController, singleton: true, only: [:create]
    resources "/session", SessionController, singleton: true, only: [:create, :delete]
    post "/session/renew", SessionController, :renew

    resources "/posts", PostController, only: [:index, :show]  # Public post listing
  end

  # LiveDashboard for development
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: BingecastApiWeb.Telemetry
    end
  end

  # Swoosh mailbox preview for development
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
