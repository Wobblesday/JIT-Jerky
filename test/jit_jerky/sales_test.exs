defmodule JITJerky.SalesTest do
  use JITJerky.DataCase

  alias JITJerky.Sales

  describe "products" do
    alias JITJerky.Sales.Product

    @valid_attrs %{name: "some name", opaque_id: "7488a646-e31f-11e4-aace-600308960662", price: "120.5", sku: "some sku"}
    @update_attrs %{name: "some updated name", opaque_id: "7488a646-e31f-11e4-aace-600308960668", price: "456.7", sku: "some updated sku"}
    @invalid_attrs %{name: nil, opaque_id: nil, price: nil, sku: nil}

    def product_fixture(attrs \\ %{}) do
      {:ok, product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sales.create_product()

      product
    end

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Sales.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Sales.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      assert {:ok, %Product{} = product} = Sales.create_product(@valid_attrs)
      assert product.name == "some name"
      assert product.opaque_id == "7488a646-e31f-11e4-aace-600308960662"
      assert product.price == Decimal.new("120.5")
      assert product.sku == "some sku"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sales.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      assert {:ok, %Product{} = product} = Sales.update_product(product, @update_attrs)
      assert product.name == "some updated name"
      assert product.opaque_id == "7488a646-e31f-11e4-aace-600308960668"
      assert product.price == Decimal.new("456.7")
      assert product.sku == "some updated sku"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Sales.update_product(product, @invalid_attrs)
      assert product == Sales.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Sales.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Sales.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Sales.change_product(product)
    end
  end
end
