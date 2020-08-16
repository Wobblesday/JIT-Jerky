defmodule JITJerkyWeb.Billing.PaymentMethodLiveTest do
  use JITJerkyWeb.ConnCase

  import Phoenix.LiveViewTest

  alias JITJerky.Billing

  @create_attrs %{card_number: "some card_number", expiration_month: 42, expiration_year: 42, name_on_card: "some name_on_card"}
  @update_attrs %{card_number: "some updated card_number", expiration_month: 43, expiration_year: 43, name_on_card: "some updated name_on_card"}
  @invalid_attrs %{card_number: nil, expiration_month: nil, expiration_year: nil, name_on_card: nil}

  defp fixture(:payment_method) do
    {:ok, payment_method} = Billing.create_payment_method(@create_attrs)
    payment_method
  end

  defp create_payment_method(_) do
    payment_method = fixture(:payment_method)
    %{payment_method: payment_method}
  end

  describe "Index" do
    setup [:create_payment_method]

    test "lists all payment_methods", %{conn: conn, payment_method: payment_method} do
      {:ok, _index_live, html} = live(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert html =~ "Listing Payment methods"
      assert html =~ payment_method.card_number
    end

    test "saves new payment_method", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert index_live |> element("a", "New Payment method") |> render_click() =~
               "New Payment method"

      assert_patch(index_live, Routes.billing_payment_method_index_path(conn, :new))

      assert index_live
             |> form("#payment_method-form", payment_method: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment_method-form", payment_method: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert html =~ "Payment method created successfully"
      assert html =~ "some card_number"
    end

    test "updates payment_method in listing", %{conn: conn, payment_method: payment_method} do
      {:ok, index_live, _html} = live(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert index_live |> element("#payment_method-#{payment_method.id} a", "Edit") |> render_click() =~
               "Edit Payment method"

      assert_patch(index_live, Routes.billing_payment_method_index_path(conn, :edit, payment_method))

      assert index_live
             |> form("#payment_method-form", payment_method: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#payment_method-form", payment_method: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert html =~ "Payment method updated successfully"
      assert html =~ "some updated card_number"
    end

    test "deletes payment_method in listing", %{conn: conn, payment_method: payment_method} do
      {:ok, index_live, _html} = live(conn, Routes.billing_payment_method_index_path(conn, :index))

      assert index_live |> element("#payment_method-#{payment_method.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#payment_method-#{payment_method.id}")
    end
  end

  describe "Show" do
    setup [:create_payment_method]

    test "displays payment_method", %{conn: conn, payment_method: payment_method} do
      {:ok, _show_live, html} = live(conn, Routes.billing_payment_method_show_path(conn, :show, payment_method))

      assert html =~ "Show Payment method"
      assert html =~ payment_method.card_number
    end

    test "updates payment_method within modal", %{conn: conn, payment_method: payment_method} do
      {:ok, show_live, _html} = live(conn, Routes.billing_payment_method_show_path(conn, :show, payment_method))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Payment method"

      assert_patch(show_live, Routes.billing_payment_method_show_path(conn, :edit, payment_method))

      assert show_live
             |> form("#payment_method-form", payment_method: @invalid_attrs)
             |> render_change() =~ "can&apos;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#payment_method-form", payment_method: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.billing_payment_method_show_path(conn, :show, payment_method))

      assert html =~ "Payment method updated successfully"
      assert html =~ "some updated card_number"
    end
  end
end
