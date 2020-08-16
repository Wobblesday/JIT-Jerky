defmodule JITJerky.Repo.Migrations.CreatePaymentMethod do
  use Ecto.Migration

  def change do
    create table(:payment_method) do
      add :card_number, :string
      add :name_on_card, :string
      add :expiration_month, :integer
      add :expiration_year, :integer

      timestamps()
    end

  end
end
