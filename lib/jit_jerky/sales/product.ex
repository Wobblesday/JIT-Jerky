defmodule JITJerky.Sales.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product" do
    field :name, :string
    field :opaque_id, Ecto.UUID
    field :price, :decimal
    field :sku, :string

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :sku, :opaque_id])
    |> validate_required([:name, :price, :sku, :opaque_id])
    |> unique_constraint(:sku)
    |> unique_constraint(:opaque_id)
  end
end
