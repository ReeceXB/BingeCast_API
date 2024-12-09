defmodule BingecastApiWeb.PostController do
  use BingecastApiWeb, :controller
  alias BingecastApi.Blog
  alias BingecastApi.Blog.Post

  def index(conn, _params) do
    posts = Blog.list_posts()
    json(conn, %{data: posts})
  end

  def create(conn, %{"data" => post_params}) do
    case Blog.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_status(:created)
        |> json(%{data: post})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{errors: changeset.errors})
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, post} <- Blog.get_post(id) do
      render(conn, "show.json", post: post)
    end
  end
end
