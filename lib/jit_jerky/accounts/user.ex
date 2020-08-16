defmodule JITJerky.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user" do
    field :email, :string
    field :name, :string
    field :telephone, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :telephone, :email, :username])
    |> validate_required([:name, :telephone, :email, :username])
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
end
