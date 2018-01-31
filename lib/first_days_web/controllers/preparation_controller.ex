defmodule FirstDaysWeb.PreparationController do
  use FirstDaysWeb, :controller
  alias FirstDays.{Repo, UserData.Answer, Preparation}

  def preparation_new(conn, _params) do
    changeset = Preparation.changeset(%Preparation{}, %{})
    render(conn, "preparation_new.html", changeset: changeset)
  end

  def preparation_create(%{assigns: %{current_user: user}} = conn, %{"preparation" => preparation}) do
    case Preparation.validate_form(%Preparation{}, preparation) do
      {:ok, _preparation_changeset} ->
        answer = Repo.get_by(Answer, user_id: user.id)
        answer_changeset = Answer.changeset(answer, %{preparation: preparation})
        preparation_changeset = Preparation.changeset(%Preparation{}, preparation)
        case Repo.update(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: preparation_path(conn, :preparation_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("preparation_new.html", changeset: preparation_changeset)
        end
      {:error, preparation_changeset} ->
        render(conn, "preparation_new.html", changeset: preparation_changeset)
    end
  end

  def preparation_show(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> put_flash(:error, "You need to fill out the first day preparation questions before seeing the template")
        |> redirect(to: page_path(conn, :first_days_index))
      answer ->
        render(conn, "preparation_show.html", answers: answer.preparation)
    end
  end

  def preparation_edit(%{assigns: %{current_user: user}} = conn, _params) do
    case Repo.get_by(Answer, user_id: user.id) do
      nil ->
        conn
        |> redirect(to: preparation_path(conn, :preparation_new))
      answer ->
        changeset =
          answer
          |> Map.get(:preparation)
          |> Map.from_struct
          |> (&Preparation.changeset(%Preparation{}, &1)).()
        render(conn, "preparation_edit.html", changeset: changeset)
    end
  end

  def preparation_update(%{assigns: %{current_user: user}} = conn, %{"preparation" => preparation}) do
    case Preparation.validate_form(%Preparation{}, preparation) do
      {:ok, _preparation_changeset} ->
        answer = Repo.get_by!(Answer, user_id: user.id)
        answer_changeset = Answer.changeset(answer, %{preparation: preparation})
        preparation_changeset = Preparation.changeset(%Preparation{}, preparation)
        case Repo.update(answer_changeset) do
          {:ok, _answer} ->
            conn
            |> redirect(to: preparation_path(conn, :preparation_show))
          {:error, _changeset} ->
            conn
            |> put_flash(:error, "Something went wrong, please try again")
            |> render("preparation_edit.html", changeset: preparation_changeset)
        end
      {:error, preparation_changeset} ->
        render(conn, "preparation_edit.html", changeset: preparation_changeset)
    end
  end
end
