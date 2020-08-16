defmodule JITJerky.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal
      add :sku, :string
      add :opaque_id, :uuid

      timestamps()
    end

    create unique_index(:products, [:sku])
    create unique_index(:products, [:opaque_id])
  end
end
