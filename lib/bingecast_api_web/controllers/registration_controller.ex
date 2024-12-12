defmodule BingecastApiWeb.Pow.RegistrationController do
  use BingecastApiWeb, :controller
  alias Ecto.Changeset
  alias Pow.Plug

  def create(conn, %{"user" => user_params}) do
    case Plug.create_user(conn, user_params) do
      {:ok, user, conn} ->
        json(conn, %{
          data: %{
            access_token: conn.private[:api_access_token],
            renewal_token: conn.private[:api_renewal_token],
            user: %{
              id: user.id,
              email: user.email
            }
          }
        })

      {:error, changeset, conn} ->
        errors = Changeset.traverse_errors(changeset, &translate_error/1)

        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: errors})
    end
  end

  defp translate_error({msg, opts}) do
    # Custom error translation function
    Phoenix.Controller.gettext(msg, opts)
  end
end
