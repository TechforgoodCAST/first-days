defmodule FirstDays.UserData.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.{UserData.Answer, Accounts.User, RoleDescription, DocumentChecklist, Preparation}


  schema "answers" do
    embeds_one :role_description, RoleDescription
    embeds_one :document_checklist, DocumentChecklist
    embeds_one :preparation, Preparation
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [])
    |> Ecto.Changeset.cast_embed(:role_description)
  end
end
