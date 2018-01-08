defmodule FirstDays.DocumentChecklist do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.DocumentChecklist

  embedded_schema do
    field :documents, {:array, :string}
  end

  @doc false
  def changeset(%DocumentChecklist{} = document_checklist, attrs) do
    document_checklist
    |> cast(attrs, [:documents])
    |> validate_required([:documents])
  end

  def validate_form(%DocumentChecklist{} = struct, params) do
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
