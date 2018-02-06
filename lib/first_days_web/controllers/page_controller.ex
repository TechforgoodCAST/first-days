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

  def finding_volunteer(conn, _params) do
    render conn, "finding_volunteer.html"
  end

  def preparation(conn, _params) do
    render conn, "preparation.html"
  end

  def feedback(conn, _params) do
    render conn, "feedback.html"
  end

  def test(conn, _params) do
    render conn, "test.html"
  end
end
