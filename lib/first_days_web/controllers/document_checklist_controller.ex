defmodule FirstDaysWeb.DocumentChecklistController do
  use FirstDaysWeb, :controller
  alias FirstDays.{DocumentChecklist, Accounts, Email, Mailer}

  def new(conn, _params) do
    changeset = DocumentChecklist.changeset(%DocumentChecklist{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Accounts.update_user_answers(user, %{document_checklist: document_checklist}) do
          {:ok, _answer} ->
            conn
            |> redirect(to: document_checklist_path(conn, :show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, gettext("Something went wrong, please try again"))
            |> render("new.html", changeset: document_checklist_changeset)
        end
      {:error, document_checklist_changeset} ->
        render(conn, "new.html", changeset: document_checklist_changeset)
    end
  end

  def show(%{assigns: %{current_user: user}} = conn, _params) do
    render(conn, "show.html", answers: user.document_checklist)
  end

  def edit(%{assigns: %{current_user: user}} = conn, _params) do
    changeset =
      user
      |> Map.get(:document_checklist)
      |> Map.from_struct
      |> (&DocumentChecklist.changeset(%DocumentChecklist{}, &1)).()
    render(conn, "edit.html", changeset: changeset)
  end

  def update(%{assigns: %{current_user: user}} = conn, %{"document_checklist" => document_checklist}) do
    case DocumentChecklist.validate_form(%DocumentChecklist{}, document_checklist) do
      {:ok, _document_checklist_changeset} ->
        document_checklist_changeset = DocumentChecklist.changeset(%DocumentChecklist{}, document_checklist)
        case Accounts.update_user_answers(user, %{document_checklist: document_checklist}) do
          {:ok, _answer} ->
            conn
            |> redirect(to: document_checklist_path(conn, :show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, gettext("Something went wrong, please try again"))
            |> render("edit.html", changeset: document_checklist_changeset)
        end
      {:error, document_checklist_changeset} ->
        render(conn, "edit.html", changeset: document_checklist_changeset)
    end
  end

  def email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.document_checklist_email(%{current_user: user, answers: user.document_checklist})
    |> Mailer.deliver_later

    updated_stage = %{"document_checklist" => true}
    updated_stages = Map.merge(user.stages, updated_stage)

    case Accounts.update_user_stage(user, %{stages: updated_stages}) do
      {:ok, _user} ->
        conn
        |> put_flash(:email_modal, :document_checklist)
        |> redirect(to: page_path(conn, :get_them_ready))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, gettext("Something went wrong, please try again"))
        |> redirect(to: page_path(conn, :get_them_ready))
    end
  end
end
