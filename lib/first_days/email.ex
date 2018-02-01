defmodule FirstDays.Email do
  use Bamboo.Phoenix, view: FirstDaysWeb.EmailView

  def welcome_email(%{current_user: current_user}) do
    new_email()
    |> to("ivan@wearecast.org.uk")
    |> from("ivan@wearecast.org.uk")
    |> subject("Welcome to the First Days!")
    |> assign(:current_user, current_user)
    |> render(:welcome_email)
  end
end
