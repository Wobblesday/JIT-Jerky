defmodule JITJerkyWeb.Billing.PaymentMethodLive.Show do
  use JITJerkyWeb, :live_view

  alias JITJerky.Billing

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:payment_method, Billing.get_payment_method!(id))}
  end

  defp page_title(:show), do: "Show Payment method"
  defp page_title(:edit), do: "Edit Payment method"
end
