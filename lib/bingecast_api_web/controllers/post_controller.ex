defmodule BingecastApiWeb.PostController do
  use BingecastApiWeb, :controller
  alias BingecastApi.Blog
  alias BingecastApiWeb.PostJSON  # Use PostJSON for rendering

  action_fallback BingecastApiWeb.FallbackController

  def index(conn, _params) do
    posts = Blog.list_posts()

    conn
    |> put_view(PostJSON)  # Set the view to PostJSON
    |> render("index.json", posts: posts)  # Use render/3 with PostJSON
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Blog.get_post(id) do
      conn
      |> put_view(PostJSON)  # Set the view to PostJSON
      |> render("show.json", post: post)  # Use render/3 with PostJSON
    end
  end
end
