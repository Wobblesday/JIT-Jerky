defmodule JITJerky.Repo do
  use Ecto.Repo,
    otp_app: :jit_jerky,
    adapter: Ecto.Adapters.Postgres
end
