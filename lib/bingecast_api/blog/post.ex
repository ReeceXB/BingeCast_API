defmodule BingecastApi.Blog.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :description, :content, :inserted_at, :updated_at]}
  schema "posts" do
    field :title, :string
    field :description, :string
    field :content, :string

    belongs_to :user, BingecastApi.Users.User

    timestamps()
  end

  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :description, :content])
    |> validate_required([:title, :description, :content])
  end
end
