defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller

  alias FirstDays.RoleDescriptionForm

  def role_description_form(conn, _params) do
    changeset = RoleDescriptionForm.changeset(%RoleDescriptionForm{}, %{})
    render(conn, "role_description.html", changeset: changeset)
  end

  def role_description_answers(conn, params) do
    IO.inspect params, label: "woooo"
  end

  def confirmation_agreement(conn, _params) do
    render conn, "confirmation_agreement.html"
  end
end
