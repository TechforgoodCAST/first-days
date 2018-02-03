defmodule FirstDaysWeb.PasswordController do
  use FirstDaysWeb, :controller
  alias FirstDays.Accounts.User

  def new(conn, _params) do
    changeset = User.email_changeset(%User{})
    render conn, "new.html", changeset: changeset, action: password_path(conn, :create)
  end

  def create(conn, %{user: user}) do
    conn
  end

end
