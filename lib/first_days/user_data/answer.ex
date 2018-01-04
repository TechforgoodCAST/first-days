defmodule FirstDays.UserData.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.UserData.Answer


  schema "answers" do
    field :answer, :map
    field :stage_id, :id
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:answer])
    |> validate_required([:answer])
  end
end
