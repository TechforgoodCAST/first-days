defmodule FirstDaysWeb.PageController do
  use FirstDaysWeb, :controller
  plug :authenticate_user when action in [:landing]
  alias FirstDays.Accounts.User

  def index(%{assigns: %{current_user: %User{}}} = conn, _params) do
    conn
    |> redirect(to: page_path(conn, :landing))
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def landing(conn, _params) do
    render conn, "landing.html"
  end

  def get_them_ready(conn, _params) do
    render conn, "get_them_ready.html"
  end

  def test(conn, _params) do
    render conn, "test.html"
  end
end
