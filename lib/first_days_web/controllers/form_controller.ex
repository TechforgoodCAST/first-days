defmodule FirstDaysWeb.FormController do
  use FirstDaysWeb, :controller
  alias FirstDays.{
                  Repo,
                  UserData,
                  State.Stage,
                  UserData.Answer,
                  RoleDescription,
                  Accounts.User,
                  DocumentChecklist,
                  Preparation
                  }

  # ROLE DESCRIPTION ACTIONS

  def role_description_new(conn, _params) do
    changeset = RoleDescription.changeset(%RoleDescription{}, %{})
    render(conn, "role_description_new.html", changeset: changeset)
  end

  def role_description_create(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        stage = Repo.get_by!(Stage, stage: "role_description_form")
        answer = %Answer{answers: role_description, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, %{})
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Repo.insert(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("role_description_show.html", answers: answer.answers)
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "role_description_new.html", changeset: role_description_changeset
        end
      {:error, role_description_changeset} ->
        render(conn, "role_description_new.html", changeset: %{role_description_changeset | action: :send})
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
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        stage = Repo.get_by!(Stage, stage: "role_description_form")
        answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
        updated_answer = %{answers: role_description, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, updated_answer)
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Repo.update(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("role_description_show.html", answers: answer.answers)
          {:error, changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "role_description_edit.html", changeset: role_description_changeset
        end
      {:error, role_description_changeset} ->
        render(conn, "role_description_edit.html", changeset: %{role_description_changeset | action: :send})
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
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        stage = Repo.get_by!(Stage, stage: "document_checklist_form")
        answer = %Answer{answers: document_checklist, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, %{})
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Repo.insert(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("document_checklist_show.html", answers: answer.answers)
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "document_checklist_new.html", changeset: document_checklist_changeset
        end
      {:error, document_checklist_changeset} ->
        render(conn, "document_checklist_new.html", changeset: %{document_checklist_changeset | action: :send})
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
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        stage = Repo.get_by!(Stage, stage: "document_checklist_form")
        answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
        updated_answer = %{answers: document_checklist, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, updated_answer)
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Repo.update(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("document_checklist_show.html", answers: answer.answers)
          {:error, changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "document_checklist_edit.html", changeset: document_checklist_changeset
        end
      {:error, document_checklist_changeset} ->
        render(conn, "document_checklist_edit.html", changeset: %{document_checklist_changeset | action: :send})
    end
  end

  # PREPARATION ACTIONS

  def preparation_new(conn, _params) do
    changeset = Preparation.changeset(%Preparation{}, %{})
    render(conn, "preparation_new.html", changeset: changeset)
  end

  def preparation_create(%{assigns: %{current_user: user}} = conn, %{"preparation" => preparation}) do
    case Preparation.validate_form(%Preparation{}, preparation) do
      {:ok, _preparation_changeset} ->
        stage = Repo.get_by!(Stage, stage: "preparation_form")
        answer = %Answer{answers: preparation, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, %{})
        preparation_changeset = Preparation.changeset(%Preparation{}, preparation)
        case Repo.insert(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("preparation_show.html", answers: answer.answers)
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "preparation_new.html", changeset: preparation_changeset
        end
      {:error, preparation_changeset} ->
        render(conn, "preparation_new.html", changeset: %{preparation_changeset | action: :send})
    end
  end

  def preparation_edit(%{assigns: %{current_user: user}} = conn, params) do
    stage = Repo.get_by!(Stage, stage: "preparation_form")
    changeset =
      Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
      |> Map.get(:answers)
      |> (&Preparation.changeset(%Preparation{}, &1)).()

    render(conn, "preparation_edit.html", changeset: changeset)
  end

  def preparation_update(%{assigns: %{current_user: user}} = conn, %{"preparation" => preparation}) do
    case Preparation.validate_form(%Preparation{}, preparation) do
      {:ok, _preparation_changeset} ->
        stage = Repo.get_by!(Stage, stage: "preparation_form")
        answer = Repo.get_by!(Answer, stage_id: stage.id, user_id: user.id)
        updated_answer = %{answers: preparation, user: user, stage: stage}
        answer_changeset = Answer.changeset(answer, updated_answer)
        preparation_changeset = Preparation.changeset(%Preparation{}, preparation)
        case Repo.update(answer_changeset) do
          {:ok, answer} ->
            conn
            |> render("preparation_show.html", answers: answer.answers)
          {:error, changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render "preparation_edit.html", changeset: preparation_changeset
        end
      {:error, preparation_changeset} ->
        render(conn, "preparation_edit.html", changeset: %{preparation_changeset | action: :send})
    end
  end
end
