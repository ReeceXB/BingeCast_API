defmodule BingecastApi.Repo do
  use Ecto.Repo,
    otp_app: :bingecast_api,
    adapter: Ecto.Adapters.SQLite3
end
