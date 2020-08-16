defmodule JITJerkyWeb.Billing.AddressLiveTest do
  use JITJerkyWeb.ConnCase

  import Phoenix.LiveViewTest

  alias JITJerky.Billing

  @create_attrs %{address_line1: "some address_line1", address_line2: "some address_line2", city: "some city", country: "some country", name: "some name", postal_code: "some postal_code", province: "some province", telephone: "some telephone"}
  @update_attrs %{address_line1: "some updated address_line1", address_line2: "some updated address_line2", city: "some updated city", country: "some updated country", name: "some updated name", postal_code: "some updated postal_code", province: "some updated province", telephone: "some updated telephone"}
  @invalid_attrs %{address_line1: nil, address_line2: nil, city: nil, country: nil, name: nil, postal_code: nil, province: nil, telephone: nil}

  defp fixture(:address) do
    {:ok, address} = Billing.create_address(@create_attrs)
    address
  end

  defp create_address(_) do
    address = fixture(:address)
    %{address: address}
  end

  describe "Index" do
    setup [:create_address]

    test "lists all addresses", %{conn: conn, address: address} do
      {:ok, _index_live, html} = live(conn, Routes.billing_address_index_path(conn, :index))

      assert html =~ "Listing Addresses"
      assert html =~ address.address_line1
    end

    test "saves new address", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.billing_address_index_path(conn, :index))

      assert index_live |> element("a", "New Address") |> render_click() =~
               "New Address"

      assert_patch(index_live, Routes.billing_address_index_path(conn, :new))

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#address-form", address: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_address_index_path(conn, :index))

      assert html =~ "Address created successfully"
      assert html =~ "some address_line1"
    end

    test "updates address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, Routes.billing_address_index_path(conn, :index))

      assert index_live |> element("#address-#{address.id} a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(index_live, Routes.billing_address_index_path(conn, :edit, address))

      assert index_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#address-form", address: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_address_index_path(conn, :index))

      assert html =~ "Address updated successfully"
      assert html =~ "some updated address_line1"
    end

    test "deletes address in listing", %{conn: conn, address: address} do
      {:ok, index_live, _html} = live(conn, Routes.billing_address_index_path(conn, :index))

      assert index_live |> element("#address-#{address.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#address-#{address.id}")
    end
  end

  describe "Show" do
    setup [:create_address]

    test "displays address", %{conn: conn, address: address} do
      {:ok, _show_live, html} = live(conn, Routes.billing_address_show_path(conn, :show, address))

      assert html =~ "Show Address"
      assert html =~ address.address_line1
    end

    test "updates address within modal", %{conn: conn, address: address} do
      {:ok, show_live, _html} = live(conn, Routes.billing_address_show_path(conn, :show, address))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Address"

      assert_patch(show_live, Routes.billing_address_show_path(conn, :edit, address))

      assert show_live
             |> form("#address-form", address: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#address-form", address: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_address_show_path(conn, :show, address))

      assert html =~ "Address updated successfully"
      assert html =~ "some updated address_line1"
    end
  end
end
