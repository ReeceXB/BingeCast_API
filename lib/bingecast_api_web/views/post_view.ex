defmodule BingecastApiWeb.PostJSON do
  use Phoenix.Component

  # Renders the index JSON response
  def index(assigns) do
    %{data: Enum.map(assigns.posts, &post(%{post: &1}))}
  end

  # Renders a single post JSON response
  def post(assigns) do
    %{
      id: assigns.post.id,
      title: assigns.post.title,
      description: assigns.post.description,
      content: assigns.post.content,
      created_at: assigns.post.inserted_at
    }
  end

  # Renders a single post as JSON for "show.json"
  def render("show.json", %{post: post}) do
    %{data: post(%{post: post})}
  end
end
