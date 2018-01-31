defmodule FirstDays.UserData.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.{UserData.Answer, Accounts.User, RoleDescription, DocumentChecklist, Preparation}


  schema "answers" do
    embeds_one :role_description, RoleDescription, on_replace: :update
    embeds_one :document_checklist, DocumentChecklist, on_replace: :update
    embeds_one :preparation, Preparation, on_replace: :update
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [])
    |> Ecto.Changeset.cast_embed(:role_description)
    |> Ecto.Changeset.cast_embed(:document_checklist)
    |> Ecto.Changeset.cast_embed(:preparation)
  end
end
