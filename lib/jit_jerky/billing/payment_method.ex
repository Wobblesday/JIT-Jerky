defmodule JITJerky.Billing.PaymentMethod do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payment_method" do
    field :card_number, :string
    field :expiration_month, :integer
    field :expiration_year, :integer
    field :name_on_card, :string
    field :payment_method, :string

    timestamps()
  end

  @doc false
  def changeset(payment_method, attrs) do
    payment_method
    |> cast(attrs, [:card_number, :name_on_card, :expiration_month, :expiration_year, :payment_method])
    |> validate_required([:card_number, :name_on_card, :expiration_month, :expiration_year, :payment_method])
  end
end
