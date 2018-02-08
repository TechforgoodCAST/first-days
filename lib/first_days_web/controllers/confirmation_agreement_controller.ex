defmodule FirstDaysWeb.ConfirmationAgreementController do
  use FirstDaysWeb, :controller

  def confirmation_agreement_show(conn, _params) do
    render conn, "confirmation_agreement_show.html"
  end

  def confirmation_agreement_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.confirmation_agreement_email(%{current_user: user})
    |> Mailer.deliver_later
    
    conn
    |> redirect(to: page_path(conn, :landing))
  end
end
