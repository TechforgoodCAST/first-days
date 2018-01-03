defmodule FirstDays.State.Stage do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.State.Stage


  schema "stages" do
    field :stage, :string

    timestamps()
  end

  @doc false
  def changeset(%Stage{} = stage, attrs) do
    stage
    |> cast(attrs, [:stage])
    |> validate_required([:stage])
  end
end
