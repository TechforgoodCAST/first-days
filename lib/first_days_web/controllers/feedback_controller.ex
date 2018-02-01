defmodule FirstDaysWeb.FeedbackController do
  use FirstDaysWeb, :controller

  def feedback_show(conn, _params) do
    render conn, "feedback_show.html"
  end
end
