defmodule FirstDaysWeb.SessionController do
  use FirstDaysWeb, :controller
  alias FirstDays.Repo

  def new(conn, _) do
    if conn.assigns.current_user do
      conn
      |> put_flash(:info, "You are already signed in!")
      |> redirect(to: page_path(conn, :index))
    else
      render conn, "new.html"
    end
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case FirstDaysWeb.Auth.login_by_email_and_pass(conn, email, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid email/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> FirstDaysWeb.Auth.logout()
    |> put_flash(:info, "You have logged out")
    |> redirect(to: page_path(conn, :index))
  end
end
