defmodule JITJerky.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :name, :string
      add :telephone, :string
      add :email, :string
      add :username, :string

      timestamps()
    end

    create unique_index(:user, [:email])
    create unique_index(:user, [:username])
  end
end
