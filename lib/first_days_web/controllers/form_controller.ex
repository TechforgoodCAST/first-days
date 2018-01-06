defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData, State.Stage, UserData.Answer, RoleDescriptionForm, Accounts.User}

  def new_role_description(conn, _params) do
    changeset = RoleDescriptionForm.changeset(%RoleDescriptionForm{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create_role_description(%{assigns: %{current_user: user}} = conn, %{"role_description_form" => role_description_form}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    answer = %Answer{answers: role_description_form, user: user, stage: stage}
    changeset = Answer.changeset(answer, %{})
    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> render("show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit_role_description(%{assigns: %{current_user: user}} = conn, params) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    changeset =
      Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
      |> Map.get(:answers)
      |> (&RoleDescriptionForm.changeset(%RoleDescriptionForm{}, &1)).()

    render(conn, "edit.html", changeset: changeset)
  end

  def update_role_description(%{assigns: %{current_user: user}} = conn, %{"role_description_form" => role_description_form}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
    updated_answer = %{answers: role_description_form, user: user, stage: stage}
    changeset = Answer.changeset(answer, updated_answer)
    case Repo.update(changeset) do
      {:ok, answer} ->
        conn
        |> render("show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def confirmation_agreement(conn, _params) do
    render conn, "confirmation_agreement.html"
  end
end
