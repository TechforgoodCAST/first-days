defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller

  def role_description(conn, _params) do
    render conn, "role_description.html"
  end

  def confirmation_agreement(conn, _params) do
    render conn, "confirmation_agreement.html"
  end
end
