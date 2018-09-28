defmodule FirstDaysWeb.StageController do
  use FirstDaysWeb, :controller
  alias FirstDays.Accounts
  plug :authenticate_user

  def update_stage(%{assigns: %{current_user: user}} = conn, params) do
    update_stages =
      params
      |> Enum.map(fn({k, v}) -> {k, string_to_bool(v)} end)
      |> Enum.into(%{})
      |> Map.take(["role_description", "confirmation_agreement", "document_checklist", "preparation", "feedback"])

    updated_stages = Map.merge(user.stages, update_stages)

    show_success_modal =
      if params["feedback"] do
        :success_modal
      else
        :no_modal
      end

    case Accounts.update_user_stage(user, %{stages: updated_stages}) do
      {:ok, _user} ->
        redirect_to = String.to_atom(params["redirect_to"])
        conn
        |> put_flash(show_success_modal, :feedback)
        |> redirect(to: page_path(conn, redirect_to))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, gettext("Something went wrong, please try again"))
        |> redirect(to: page_path(conn, :landing))
    end
  end

  defp string_to_bool("true"), do: true
  defp string_to_bool(_string), do: false
end
