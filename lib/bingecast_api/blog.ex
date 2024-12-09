defmodule BingecastApi.Blog do
  alias BingecastApi.Repo
  alias BingecastApi.Blog.Post

  import Ecto.Query

  def list_posts do
    Repo.all(from p in Post, order_by: [desc: p.inserted_at])
  end

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def get_post(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end
end
