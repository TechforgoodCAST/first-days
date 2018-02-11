defmodule FirstDaysWeb.ConfirmationAgreementController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Email, Mailer, Accounts}

  def confirmation_agreement_show(conn, _params) do
    render conn, "confirmation_agreement_show.html"
  end

  def confirmation_agreement_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.confirmation_agreement_email(%{current_user: user})
    |> Mailer.deliver_later

    updated_stage = %{"confirmation_agreement" => true}
    updated_stages = Map.merge(user.stages, updated_stage)

    case Accounts.update_user_stage(user, %{stages: updated_stages}) do
      {:ok, _user} ->
        conn
        |> put_flash(:email_modal, :confirmation_agreeement)
        |> redirect(to: page_path(conn, :get_them_ready))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, please try again")
        |> redirect(to: page_path(conn, :get_them_ready))
    end
  end
end
