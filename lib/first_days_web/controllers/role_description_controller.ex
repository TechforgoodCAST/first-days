defmodule FirstDaysWeb.RoleDescriptionController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData.Answer, RoleDescription}


  def role_description_new(conn, _params) do
    changeset = RoleDescription.changeset(%RoleDescription{}, %{})
    render(conn, "role_description_new.html", changeset: changeset)
  end

  def role_description_create(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        answer = %Answer{user: user}
        answer_changeset = Answer.changeset(answer, %{role_description: role_description})
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Repo.insert(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: role_description_path(conn, :role_description_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("role_description_new.html", changeset: role_description_changeset)
        end
      {:error, role_description_changeset} ->
        render(conn, "role_description_new.html", changeset: role_description_changeset)
    end
  end

  def role_description_show(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> put_flash(:error, "You need to fill out the role description questions before seeing the template")
        |> redirect(to: page_path(conn, :first_days_index))
      answer ->
        render(conn, "role_description_show.html", answers: answer.role_description)
    end
  end

  def role_description_edit(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> redirect(to: role_description_path(conn, :role_description_new))
      answer ->
        changeset =
          answer
          |> Map.get(:role_description)
          |> Map.from_struct
          |> (&RoleDescription.changeset(%RoleDescription{}, &1)).()
        render(conn, "role_description_edit.html", changeset: changeset)
    end
  end

  def role_description_update(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        answer = Repo.get_by!(Answer, user_id: user.id)
        updated_answer = %{role_description: role_description}
        answer_changeset = Answer.changeset(answer, updated_answer)
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Repo.update(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: role_description_path(conn, :role_description_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("role_description_edit.html", changeset: role_description_changeset)
        end
      {:error, role_description_changeset} ->
        render(conn, "role_description_edit.html", changeset: role_description_changeset)
    end
  end
end
