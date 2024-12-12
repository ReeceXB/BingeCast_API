defmodule BingecastApi.Blog do
  alias BingecastApi.Repo
  alias BingecastApi.Blog.Post

  import Ecto.Query

  def list_posts do
    Repo.all(from p in Post, order_by: [desc: p.inserted_at])
  end

  def list_posts(%BingecastApi.Users.User{id: user_id}) do
    Repo.all(from p in Post, where: p.user_id == ^user_id, preload: [:user], order_by: [desc: :inserted_at])
  end

  def create_post!(%BingecastApi.Users.User{} = user, attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert!()
    |> Repo.preload([:user])
  end

  def get_post(id) do
    case Repo.get(Post, id) do
      nil -> {:error, :not_found}
      post -> {:ok, post}
    end
  end
end
