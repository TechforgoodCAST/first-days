defmodule FirstDaysWeb.PasswordController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Accounts.User, Repo, Accounts}
  plug :put_layout, {FirstDaysWeb.LayoutView, :signed_out_layout}

  use Timex

  def new(conn, _params) do
    changeset = User.email_changeset(%User{})
    render conn, "new.html", changeset: changeset, action: password_path(conn, :create)
  end

  def create(conn, %{"user" => email_params}) do
    email = email_params["email"]
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

  def edit(conn, %{"id" => token}) do
    user = Repo.get_by(User, reset_password_token: token)
    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
      user ->
        if expired?(user.reset_token_sent_at) do
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!

          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: password_path(conn, :new))
        else
          changeset = Accounts.change_user(user)
          conn
          |> render("edit.html", changeset: changeset, token: token)
        end
    end
  end

  def update(conn, %{"id" => token, "user" => pw_params}) do
    user = Repo.get_by(User, reset_password_token: token)
    case user do
      nil ->
        conn
        |> put_flash(:error, "Invalid reset token")
        |> redirect(to: password_path(conn, :new))
      user ->
        if expired?(user.reset_token_sent_at) do
          User.password_token_changeset(user, %{
            reset_password_token: nil,
            reset_token_sent_at: nil
          })
          |> Repo.update!

          conn
          |> put_flash(:error, "Password reset token expired")
          |> redirect(to: password_path(conn, :new))
        else
          changeset = User.new_password_changeset(user, pw_params)
          case Repo.update(changeset) do
            {:ok, _user} ->
              User.password_token_changeset(user, %{
                reset_password_token: nil,
                reset_token_sent_at: nil
              })
              |> Repo.update!

              conn
              |> put_flash(:info, "Password reset successfully!")
              |> redirect(to: page_path(conn, :index))
            {:error, changeset} ->
              conn
              |> render("edit.html", changeset: changeset, token: token)
          end
        end
      end
  end

  defp reset_password_token(user) do
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

  defp expired?(datetime) do
    Timex.after?(Timex.now, Timex.shift(datetime, days: 1))
  end
end
