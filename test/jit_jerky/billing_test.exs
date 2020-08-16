defmodule JITJerky.BillingTest do
  use JITJerky.DataCase

  alias JITJerky.Billing

  describe "addresses" do
    alias JITJerky.Billing.Address

    @valid_attrs %{address_line1: "some address_line1", address_line2: "some address_line2", city: "some city", country: "some country", name: "some name", postal_code: "some postal_code", province: "some province", telephone: "some telephone"}
    @update_attrs %{address_line1: "some updated address_line1", address_line2: "some updated address_line2", city: "some updated city", country: "some updated country", name: "some updated name", postal_code: "some updated postal_code", province: "some updated province", telephone: "some updated telephone"}
    @invalid_attrs %{address_line1: nil, address_line2: nil, city: nil, country: nil, name: nil, postal_code: nil, province: nil, telephone: nil}

    def address_fixture(attrs \\ %{}) do
      {:ok, address} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Billing.create_address()

      address
    end

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Billing.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Billing.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      assert {:ok, %Address{} = address} = Billing.create_address(@valid_attrs)
      assert address.address_line1 == "some address_line1"
      assert address.address_line2 == "some address_line2"
      assert address.city == "some city"
      assert address.country == "some country"
      assert address.name == "some name"
      assert address.postal_code == "some postal_code"
      assert address.province == "some province"
      assert address.telephone == "some telephone"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()
      assert {:ok, %Address{} = address} = Billing.update_address(address, @update_attrs)
      assert address.address_line1 == "some updated address_line1"
      assert address.address_line2 == "some updated address_line2"
      assert address.city == "some updated city"
      assert address.country == "some updated country"
      assert address.name == "some updated name"
      assert address.postal_code == "some updated postal_code"
      assert address.province == "some updated province"
      assert address.telephone == "some updated telephone"
    end

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_address(address, @invalid_attrs)
      assert address == Billing.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Billing.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Billing.change_address(address)
    end
  end

  describe "payment_methods" do
    alias JITJerky.Billing.PaymentMethod

    @valid_attrs %{card_number: "some card_number", expiration_month: 42, expiration_year: 42, name_on_card: "some name_on_card", payment_method: "some payment_method"}
    @update_attrs %{card_number: "some updated card_number", expiration_month: 43, expiration_year: 43, name_on_card: "some updated name_on_card", payment_method: "some updated payment_method"}
    @invalid_attrs %{card_number: nil, expiration_month: nil, expiration_year: nil, name_on_card: nil, payment_method: nil}

    def payment_method_fixture(attrs \\ %{}) do
      {:ok, payment_method} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Billing.create_payment_method()

      payment_method
    end

    test "list_payment_methods/0 returns all payment_methods" do
      payment_method = payment_method_fixture()
      assert Billing.list_payment_methods() == [payment_method]
    end

    test "get_payment_method!/1 returns the payment_method with given id" do
      payment_method = payment_method_fixture()
      assert Billing.get_payment_method!(payment_method.id) == payment_method
    end

    test "create_payment_method/1 with valid data creates a payment_method" do
      assert {:ok, %PaymentMethod{} = payment_method} = Billing.create_payment_method(@valid_attrs)
      assert payment_method.card_number == "some card_number"
      assert payment_method.expiration_month == 42
      assert payment_method.expiration_year == 42
      assert payment_method.name_on_card == "some name_on_card"
      assert payment_method.payment_method == "some payment_method"
    end

    test "create_payment_method/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_payment_method(@invalid_attrs)
    end

    test "update_payment_method/2 with valid data updates the payment_method" do
      payment_method = payment_method_fixture()
      assert {:ok, %PaymentMethod{} = payment_method} = Billing.update_payment_method(payment_method, @update_attrs)
      assert payment_method.card_number == "some updated card_number"
      assert payment_method.expiration_month == 43
      assert payment_method.expiration_year == 43
      assert payment_method.name_on_card == "some updated name_on_card"
      assert payment_method.payment_method == "some updated payment_method"
    end

    test "update_payment_method/2 with invalid data returns error changeset" do
      payment_method = payment_method_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_payment_method(payment_method, @invalid_attrs)
      assert payment_method == Billing.get_payment_method!(payment_method.id)
    end

    test "delete_payment_method/1 deletes the payment_method" do
      payment_method = payment_method_fixture()
      assert {:ok, %PaymentMethod{}} = Billing.delete_payment_method(payment_method)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_payment_method!(payment_method.id) end
    end

    test "change_payment_method/1 returns a payment_method changeset" do
      payment_method = payment_method_fixture()
      assert %Ecto.Changeset{} = Billing.change_payment_method(payment_method)
    end
  end
end
