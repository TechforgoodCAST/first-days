defmodule FirstDaysWeb.DocumentChecklistController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData.Answer, DocumentChecklist}


  def document_checklist_new(conn, _params) do
    changeset = DocumentChecklist.changeset(%DocumentChecklist{}, %{})
    render(conn, "document_checklist_new.html", changeset: changeset)
  end

  def document_checklist_create(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        answer = %Answer{user: user}
        answer_changeset = Answer.changeset(answer, %{document_checklist: document_checklist})
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Repo.insert(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: document_checklist_path(conn, :document_checklist_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("document_checklist_new.html", changeset: document_checklist_changeset)
        end
      {:error, document_checklist_changeset} ->
        render(conn, "document_checklist_new.html", changeset: document_checklist_changeset)
    end
  end

  def document_checklist_show(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> put_flash(:error, "You need to fill out the document checklist questions before seeing the template")
        |> redirect(to: page_path(conn, :first_days_index))
      answer ->
        render(conn, "document_checklist_show.html", answers: answer.document_checklist)
    end
  end

  def document_checklist_edit(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> redirect(to: document_checklist_path(conn, :document_checklist_new))
      answer ->
        changeset =
          answer
          |> Map.get(:document_checklist)
          |> Map.from_struct
          |> (&DocumentChecklist.changeset(%DocumentChecklist{}, &1)).()
        render(conn, "document_checklist_edit.html", changeset: changeset)
    end
  end

  def document_checklist_update(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        answer = Repo.get_by!(Answer, user_id: user.id)
        updated_answer = %{document_checklist: document_checklist}
        answer_changeset = Answer.changeset(answer, updated_answer)
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Repo.update(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: document_checklist_path(conn, :document_checklist_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("document_checklist_edit.html", changeset: document_checklist_changeset)
        end
      {:error, document_checklist_changeset} ->
        render(conn, "document_checklist_edit.html", changeset: document_checklist_changeset)
    end
  end
end
