defmodule FirstDays.Email do
  use Bamboo.Phoenix, view: FirstDaysWeb.EmailView

  def welcome_email(%{current_user: current_user}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("Welcome to the First Days!")
    |> assign(:current_user, current_user)
    |> render(:welcome_email)
  end

  def reset_password_email(to_email, token) do
    new_email()
    |> to(to_email)
    |> from("ivan@wearecast.org.uk")
    |> subject("Reset passwords instructions")
    |> text_body("Please visit http://localhost:4000/forgot-password/#{token}/edit to reset your password")
  end
end
