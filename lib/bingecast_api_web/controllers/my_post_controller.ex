defmodule BingecastApiWeb.MyPostController do
  use BingecastApiWeb, :controller
  alias BingecastApi.Blog
  alias BingecastApiWeb.PostJSON  # Use PostJSON for rendering

  action_fallback BingecastApiWeb.FallbackController

  def index(conn, _params) do
    posts =
      conn
      |> Pow.Plug.current_user()
      |> Blog.list_posts()

    conn
    |> put_view(PostJSON)  # Set the view to PostJSON
    |> render("index.json", posts: posts)  # Render with PostJSON
  end

  def create(conn, %{"data" => post_params}) do
    post =
      conn
      |> Pow.Plug.current_user()
      |> Blog.create_post!(post_params)

    conn
    |> put_view(PostJSON)  # Set the view to PostJSON
    |> render("show.json", post: post)  # Render with PostJSON
  end
end
