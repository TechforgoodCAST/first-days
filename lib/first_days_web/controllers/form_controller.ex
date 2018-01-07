defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData, State.Stage, UserData.Answer, RoleDescription, Accounts.User, DocumentChecklist}

  # ROLE DESCRIPTION ACTIONS

  def role_description_new(conn, _params) do
    changeset = RoleDescription.changeset(%RoleDescription{}, %{})
    render(conn, "role_description_new.html", changeset: changeset)
  end

  def role_description_create(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    answer = %Answer{answers: role_description, user: user, stage: stage}
    changeset = Answer.changeset(answer, %{})
    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> render("role_description_show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "role_description_new.html", changeset: changeset)
    end
  end

  def role_description_edit(%{assigns: %{current_user: user}} = conn, params) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    changeset =
      Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
      |> Map.get(:answers)
      |> (&RoleDescription.changeset(%RoleDescription{}, &1)).()

    render(conn, "role_description_edit.html", changeset: changeset)
  end

  def role_description_update(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    stage = Repo.get_by!(Stage, stage: "role_description_form")
    answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
    updated_answer = %{answers: role_description, user: user, stage: stage}
    changeset = Answer.changeset(answer, updated_answer)
    case Repo.update(changeset) do
      {:ok, answer} ->
        conn
        |> render("role_description_show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "role_description_edit.html", changeset: changeset)
    end
  end

  # CONFIRMATION AGREEMENT ACTIONS

  def confirmation_agreement_show(conn, _params) do
    render conn, "confirmation_agreement_show.html"
  end

  # DOCUMENT CHECKLIST ACTION.

  def document_checklist_new(conn, _params) do
    changeset = DocumentChecklist.changeset(%DocumentChecklist{}, %{})
    render(conn, "document_checklist_new.html", changeset: changeset)
  end

  def document_checklist_create(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    stage = Repo.get_by!(Stage, stage: "document_checklist_form")
    answer = %Answer{answers: document_checklist, user: user, stage: stage}
    changeset = Answer.changeset(answer, %{})
    case Repo.insert(changeset) do
      {:ok, answer} ->
        conn
        |> render("document_checklist_show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "document_checklist_new.html", changeset: changeset)
    end
  end

  def document_checklist_edit(%{assigns: %{current_user: user}} = conn, params) do
    stage = Repo.get_by!(Stage, stage: "document_checklist_form")
    changeset =
      Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
      |> Map.get(:answers)
      |> (&DocumentChecklist.changeset(%DocumentChecklist{}, &1)).()

    render(conn, "document_checklist_edit.html", changeset: changeset)
  end

  def document_checklist_update(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    stage = Repo.get_by!(Stage, stage: "document_checklist_form")
    answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
    updated_answer = %{answers: document_checklist, user: user, stage: stage}
    changeset = Answer.changeset(answer, updated_answer)
    case Repo.update(changeset) do
      {:ok, answer} ->
        conn
        |> render("document_checklist_show.html", answers: answer.answers)
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "document_checklist_edit.html", changeset: changeset)
    end
  end

  # PREPARATION CHECKLIST ACTION.

  def preparation_checklist_new(conn, _params) do
    changeset = DocumentChecklist.changeset(%DocumentChecklist{}, %{})
    render(conn, "preparation_checklist_new.html", changeset: changeset)
  end
end
