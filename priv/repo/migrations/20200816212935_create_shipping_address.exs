defmodule JITJerky.Repo.Migrations.CreateShippingAddress do
  use Ecto.Migration

  def change do
    create table(:shipping_address) do
      add :country, :string
      add :name, :string
      add :address_line1, :string
      add :address_line2, :string
      add :city, :string
      add :province, :string
      add :postal_code, :string
      add :telephone, :string
      add :delivery_instructions, :map

      timestamps()
    end

  end
end
