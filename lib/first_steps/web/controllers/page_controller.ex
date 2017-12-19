defmodule FirstSteps.Web.PageController do
  use FirstSteps.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
