defmodule JITJerky.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:product) do
      add :name, :string
      add :price, :decimal
      add :sku, :string
      add :opaque_id, :uuid

      timestamps()
    end

    create unique_index(:product, [:sku])
    create unique_index(:product, [:opaque_id])
  end
end
