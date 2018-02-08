defmodule FirstDaysWeb.ConfirmationAgreementController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Email, Mailer}

  def confirmation_agreement_show(conn, _params) do
    render conn, "confirmation_agreement_show.html"
  end

  def confirmation_agreement_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.confirmation_agreement_email(%{current_user: user})
    |> Mailer.deliver_later

    conn
    |> put_flash(:modal, :confirmation_agreeement)
    |> redirect(to: page_path(conn, :get_them_ready))
  end
end
