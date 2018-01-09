defmodule FirstDays.DocumentChecklist do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.DocumentChecklist

  embedded_schema do
    field :photo_id, :boolean
    field :proof_of_identity, :boolean
    field :proof_of_address, :boolean
    field :volunteer_requirements, :boolean
    field :emergency_contact_details, :boolean
    field :dbs_check, :boolean
    field :proof_of_residency, :boolean
    field :bank_details, :boolean
    field :proof_of_qualifications, :boolean
    field :other_document, :string
  end

  @fields [
          :photo_id,
          :proof_of_identity,
          :proof_of_address,
          :volunteer_requirements,
          :emergency_contact_details,
          :dbs_check,
          :proof_of_residency,
          :bank_details,
          :proof_of_qualifications,
          :other_document
          ]

  @doc false
  def changeset(%DocumentChecklist{} = document_checklist, attrs) do
    document_checklist
    |> cast(attrs, @fields)
    |> validate_required(List.delete(@fields, :other_document))
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
