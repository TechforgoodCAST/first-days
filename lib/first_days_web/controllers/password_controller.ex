defmodule FirstDaysWeb.PasswordController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Accounts.User, Repo}

  use Timex

  def new(conn, _params) do
    changeset = User.email_changeset(%User{})
    render conn, "new.html", changeset: changeset, action: password_path(conn, :create)
  end

  def create(conn, %{"user" => user}) do
    email = user["email"]
    user = case email do
      nil ->
        nil
    email ->
      User
      |> Repo.get_by(email: email)
    end

    case user do
      nil ->
        conn
        |> put_flash(:error, "We don't recognise that email, try again?")
        |> redirect(to: password_path(conn, :new))
      user ->
        user = reset_password_token(user)

        FirstDays.Email.reset_password_email(email, user.reset_password_token)
        |> FirstDays.Mailer.deliver_later()

        conn
        |> put_flash(:info, "We've sent you an email with instructions on how to reset your password")
        |> redirect(to: page_path(conn, :index))
    end
  end

  def reset_password_token(user) do
    token = random_string(48)
    sent_at = DateTime.utc_now

    # TODO: abstract out into Accounts module
    user
    |> User.password_token_changeset(%{reset_password_token: token, reset_token_sent_at: sent_at})
    |> Repo.update!
  end

  defp random_string(length) do
    length
    |> :crypto.strong_rand_bytes
    |> Base.url_encode64
    |> binary_part(0, length)
  end
end
