defmodule FirstDaysWeb.RoleDescriptionController do
  use FirstDaysWeb, :controller
  alias FirstDays.{RoleDescription, Accounts, Email, Mailer}


  def role_description_new(conn, _params) do
    changeset = RoleDescription.changeset(%RoleDescription{}, %{})
    render(conn, "role_description_new.html", changeset: changeset)
  end

  def role_description_create(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Accounts.update_user_answers(user, %{role_description: role_description}) do
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
    render(conn, "role_description_show.html", answers: user.role_description)
  end

  def role_description_edit(%{assigns: %{current_user: user}} = conn, _params) do
    changeset =
      user
      |> Map.get(:role_description)
      |> Map.from_struct
      |> (&RoleDescription.changeset(%RoleDescription{}, &1)).()
    render(conn, "role_description_edit.html", changeset: changeset)
  end

  def role_description_update(%{assigns: %{current_user: user}} = conn, %{"role_description" => role_description}) do
    case RoleDescription.validate_form(%RoleDescription{}, role_description) do
      {:ok, _role_description_changeset} ->
        role_description_changeset = RoleDescription.changeset(%RoleDescription{}, role_description)
        case Accounts.update_user_answers(user, %{role_description: role_description}) do
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

  def role_description_email(%{assigns: %{current_user: user}} = conn, _params) do
    Email.role_description_email(%{current_user: user, answers: user.role_description})
    |> Mailer.deliver_later

    conn
    |> put_flash(:modal, :role_description)
    |> redirect(to: page_path(conn, :landing))
  end

end
