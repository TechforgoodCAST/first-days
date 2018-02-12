defmodule FirstDaysWeb.RoleDescriptionController do
  use FirstDaysWeb, :controller
  alias FirstDays.{RoleDescription, Accounts, Email, Mailer}


  def new(conn, _params) do
    changeset = RoleDescription.changeset(%RoleDescription{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Accounts.update_user_answers(user, %{role_description: role_description}) do
          {:ok, _answer} ->
            conn
            |> redirect(to: role_description_path(conn, :show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("new.html", changeset: role_description_changeset)
        end
      {:error, role_description_changeset} ->
        render(conn, "new.html", changeset: role_description_changeset)
    end
  end

  def show(%{assigns: %{current_user: user}} = conn, _params) do
    render(conn, "show.html", answers: user.role_description)
  end

  def edit(%{assigns: %{current_user: user}} = conn, _params) do
    changeset =
      user
      |> Map.get(:role_description)
      |> Map.from_struct
      |> (&RoleDescription.changeset(%RoleDescription{}, &1)).()
    render(conn, "edit.html", changeset: changeset)
  end

  def update(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Accounts.update_user_answers(user, %{role_description: role_description}) do
          {:ok, _answer} ->
            conn
            |> redirect(to: role_description_path(conn, :show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("edit.html", changeset: role_description_changeset)
        end
      {:error, role_description_changeset} ->
        render(conn, "edit.html", changeset: role_description_changeset)
    end
  end

  def email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.role_description_email(%{current_user: user, answers: user.role_description})
    |> Mailer.deliver_later

    updated_stage = %{"role_description" => true}
    updated_stages = Map.merge(user.stages, updated_stage)

    case Accounts.update_user_stage(user, %{stages: updated_stages}) do
      {:ok, _user} ->
        conn
        |> put_flash(:email_modal, :role_description)
        |> redirect(to: page_path(conn, :landing))
      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Something went wrong, please try again")
        |> redirect(to: page_path(conn, :landing))
    end
  end
end
