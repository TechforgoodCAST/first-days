defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData, State.Stage, UserData.Answer, RoleDescriptionForm, Accounts.User}

  def role_description_form(conn, _params) do
    changeset = RoleDescriptionForm.changeset(%RoleDescriptionForm{}, %{})
    render(conn, "role_description.html", changeset: changeset)
  end

  def role_description_answers(%{assigns: %{current_user: %User{} = user}} = conn, %{"role_description_form" => role_description_form}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    answer = %Answer{answers: role_description_form, user: user, stage: stage}
    changeset = Answer.changeset(answer, %{})
    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> render("role_description_template.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "role_description.html", changeset: changeset)
    end
  end

  def edit_role_description_form(%{assigns: %{current_user: %User{} = user}} = conn, params) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    changeset =
      Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
      |> Map.get(:answers)
      |> (&RoleDescriptionForm.changeset(%RoleDescriptionForm{}, &1)).()

    render(conn, "role_description.html", changeset: changeset)
  end

  def confirmation_agreement(conn, _params) do
    render conn, "confirmation_agreement.html"
  end
end
