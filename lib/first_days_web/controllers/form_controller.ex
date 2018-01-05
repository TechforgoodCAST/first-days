defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData}
  alias FirstDays.State.Stage

  alias FirstDays.RoleDescriptionForm

  def role_description_form(conn, _params) do
    changeset = RoleDescriptionForm.changeset(%RoleDescriptionForm{}, %{})
    render(conn, "role_description.html", changeset: changeset)
  end

  # TODO: add role_description_form changeset for validation and get rid of User.create_answer
  def role_description_answers(conn, %{"role_description_form" => role_description_form}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    user = conn.assigns.current_user
    user_answers = %{"stage_id" => stage.id, "user_id" => user.id, "answers" => role_description_form}
    case UserData.create_answer(user_answers) do
      {:ok, answer} ->
        conn
        |> render("role_description_template.html", answers: answer.answers)
        # |> put_flash(:info, "User created successfully.")
        # |> redirect(to: form_path(conn, :confirmation_agreement))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "role_description.html", changeset: changeset)
    end
  end

  def confirmation_agreement(conn, _params) do
    render conn, "confirmation_agreement.html"
  end
end
