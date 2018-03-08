defmodule FirstDaysWeb.SessionController do
  use FirstDaysWeb, :controller
  alias FirstDays.Repo
  plug :put_layout, {FirstDaysWeb.LayoutView, :signed_out_layout}

  def new(conn, _) do
    if conn.assigns.current_user do
      conn
      |> redirect(to: page_path(conn, :landing))
    else
      render conn, "new.html"
    end
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case FirstDaysWeb.Plugs.Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> redirect(to: page_path(conn, :landing))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, gettext("Invalid email/password combination"))
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> FirstDaysWeb.Plugs.Auth.logout()
    |> put_flash(:info, gettext("You've logged out"))
    |> redirect(to: session_path(conn, :new))
  end
end
