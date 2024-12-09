# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BingecastApi.Repo.insert!(%BingecastApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias BingecastApi.Repo
alias BingecastApi.Blog.Post

Repo.insert!(%Post{
  title: "My first post",
  description: "My first post description",
  content: "Content of the first post",
  inserted_at: ~N[2023-10-18 08:56:06]
})

Repo.insert!(%Post{
  title: "My second post",
  description: "My second post description",
  content: "Content of the second post",
  inserted_at: ~N[2023-10-18 11:10:41]
})
