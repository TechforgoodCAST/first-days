defmodule FirstDaysWeb.FeedbackController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Email, Mailer, Accounts}

  def feedback_show(conn, _params) do
    render conn, "feedback_show.html"
  end

  def feedback_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.feedback_email(%{current_user: user})
    |> Mailer.deliver_later

    updated_stage = %{"feedback" => true}
    updated_stages = Map.merge(user.stages, updated_stage)

    case Accounts.update_user_stage(user, %{stages: updated_stages}) do
      {:ok, _user} ->
        conn
        |> put_flash(:modal_success, :feedback)
        |> redirect(to: page_path(conn, :landing))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, please try again")
        |> redirect(to: page_path(conn, :landing))
    end
  end
end
