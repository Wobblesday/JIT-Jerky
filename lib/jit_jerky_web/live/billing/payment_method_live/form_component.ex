defmodule JITJerkyWeb.Billing.PaymentMethodLive.FormComponent do
  use JITJerkyWeb, :live_component

  alias JITJerky.Billing

  @impl true
  def update(%{payment_method: payment_method} = assigns, socket) do
    changeset = Billing.change_payment_method(payment_method)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"payment_method" => payment_method_params}, socket) do
    changeset =
      socket.assigns.payment_method
      |> Billing.change_payment_method(payment_method_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"payment_method" => payment_method_params}, socket) do
    save_payment_method(socket, socket.assigns.action, payment_method_params)
  end

  defp save_payment_method(socket, :edit, payment_method_params) do
    case Billing.update_payment_method(socket.assigns.payment_method, payment_method_params) do
      {:ok, _payment_method} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment method updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_payment_method(socket, :new, payment_method_params) do
    case Billing.create_payment_method(payment_method_params) do
      {:ok, _payment_method} ->
        {:noreply,
         socket
         |> put_flash(:info, "Payment method created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
