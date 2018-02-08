defmodule FirstDaysWeb.FeedbackController do
  use FirstDaysWeb, :controller

  def feedback_show(conn, _params) do
    render conn, "feedback_show.html"
  end

  def feedback_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.feedback_email(%{current_user: user})
    |> Mailer.deliver_later
    
    conn
    |> redirect(to: page_path(conn, :landing))
  end
end
