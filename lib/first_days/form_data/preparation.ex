defmodule FirstDays.Preparation do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.Preparation

  embedded_schema do
    field :first_day_date, :date
    field :dress_code, :string
    field :first_day_expectations, :string
    field :other_details, :string
  end

  @fields [
          :first_day_date,
          :dress_code,
          :first_day_expectations,
          :other_details
          ]

  @doc false
  def changeset(%Preparation{} = preparation, attrs) do
    preparation
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end

  def validate_form(%Preparation{} = struct, params) do
    change =
      struct
      |> changeset(params)
      |> update_embedded_action(:validated)

    case change do
      %Ecto.Changeset{valid?: true} = changeset ->
        {:ok, changeset}
      changeset ->
        {:error, changeset}
    end
  end

  defp update_embedded_action(changeset, action) do
    %{changeset | action: action}
  end
end
