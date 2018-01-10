defmodule FirstDays.State.Stage do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.State.Stage


  schema "stages" do
    field :stage, :string
  end

  @doc false
  def changeset(%Stage{} = stage, attrs) do
    stage
    |> cast(attrs, [:stage])
    |> validate_required([:stage])
  end

  def stages do
    [
    "role_description_form",
    "role_description_template",
    "confirmation_agreement_template",
    "document_checklist_form",
    "document_checklist_template",
    "preparation_form",
    "preparation_template",
    "feedback_form"
    ]
  end
end
