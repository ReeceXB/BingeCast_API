defmodule BingecastApi.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :string
      add :content, :text

      timestamps()
    end
  end
end
