defmodule FirstSteps.Email do
  import Bamboo.Email

  def welcome_email do
    new_email()
    |> to("ivan@wearecast.org.uk")
    |> from("ivan@wearecast.org.uk")
    |> subject("Welcome to the service!")
    |> html_body("<strong>Thanks for joning!</strong>")
    |> html_body("<strong>Thanks for joning!</strong>")
  end
end
