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
    |> from("hello@firstdayswales.co.uk")
    |> subject("Reset passwords instructions")
    |> text_body("Please visit https://first-days.herokuapp.com/forgot-password/#{token}/edit to reset your password")
  end

  def role_description_email(%{current_user: current_user, answers: answers}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("First Days - Role description")
    |> assign(:current_user, current_user)
    |> assign(:answers, answers)
    |> render(:role_description_email)
  end

  def document_checklist_email(%{current_user: current_user, answers: answers}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("First Days - Document list")
    |> assign(:current_user, current_user)
    |> assign(:answers, answers)
    |> render(:document_checklist_email)
  end

  def preparation_email(%{current_user: current_user, answers: answers}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("First Days - First day preparation")
    |> assign(:current_user, current_user)
    |> assign(:answers, answers)
    |> render(:preparation_email)
  end

  def confirmation_agreement_email(%{current_user: current_user}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("First Days - Volunteer agreement")
    |> assign(:current_user, current_user)
    |> render(:confirmation_agreement_email)
  end

  def feedback_email(%{current_user: current_user}) do
    new_email()
    |> to(current_user.email)
    |> from("hello@firstdayswales.co.uk")
    |> subject("First Days - Feedback")
    |> assign(:current_user, current_user)
    |> render(:feedback_email)
  end
end
