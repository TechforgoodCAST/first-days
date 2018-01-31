defmodule FirstDaysWeb.ConfirmationAgreementController do
  use FirstDaysWeb, :controller

  def confirmation_agreement_show(conn, _params) do
    render conn, "confirmation_agreement_show.html"
  end
end
