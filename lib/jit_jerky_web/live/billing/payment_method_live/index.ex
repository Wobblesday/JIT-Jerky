defmodule JITJerkyWeb.Billing.PaymentMethodLive.Index do
  use JITJerkyWeb, :live_view

  alias JITJerky.Billing
  alias JITJerky.Billing.PaymentMethod

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :payment_methods, list_payment_methods())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Payment method")
    |> assign(:payment_method, Billing.get_payment_method!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Payment method")
    |> assign(:payment_method, %PaymentMethod{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Payment methods")
    |> assign(:payment_method, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    payment_method = Billing.get_payment_method!(id)
    {:ok, _} = Billing.delete_payment_method(payment_method)

    {:noreply, assign(socket, :payment_methods, list_payment_methods())}
  end

  defp list_payment_methods do
    Billing.list_payment_methods()
  end
end
