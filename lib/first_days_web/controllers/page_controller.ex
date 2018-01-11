defmodule FirstDaysWeb.PageController do
  use FirstDaysWeb, :controller
  plug :authenticate_user when action in [:first_days_index]
  alias FirstDays.Accounts.User

  def index(%{assigns: %{current_user: %User{}}} = conn, _params) do
    conn
    |> redirect(to: page_path(conn, :first_days_index))
  end

  def index(conn, _params) do
    render conn, "index.html"
  end

  def first_days_index(conn, _params) do
    render conn, "first_days_index.html"
  end
end
