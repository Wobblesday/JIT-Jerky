defmodule JITJerky.Billing.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "address" do
    field :address_line1, :string
    field :address_line2, :string
    field :city, :string
    field :country, :string
    field :name, :string
    field :postal_code, :string
    field :province, :string
    field :telephone, :string

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:country, :name, :address_line1, :address_line2, :city, :province, :postal_code, :telephone])
    |> validate_required([:country, :name, :address_line1, :address_line2, :city, :province, :postal_code, :telephone])
  end
end
