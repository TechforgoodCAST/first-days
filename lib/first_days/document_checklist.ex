defmodule FirstDays.DocumentChecklist do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.DocumentChecklist

  embedded_schema do
    field :area, :string
    field :charity_number, :string
    field :contact_details, :string
    field :description, :string
    field :finance_skills, :string
    field :how_will_work_help, :string
    field :location, :string
    field :organisation_achievements, :string
    field :organisation_mission, :string
    field :skills_to_be_gained, :string
    field :website_link, :string
    field :work_frequency, :string
    field :work_length, :string
  end

  @fields [
          :description,
          :area,
          :finance_skills,
          :work_frequency,
          :work_length,
          :location,
          :contact_details,
          :organisation_mission,
          :organisation_achievements,
          :charity_number,
          :website_link,
          :how_will_work_help,
          :skills_to_be_gained
          ]

  @doc false
  def changeset(%DocumentChecklist{} = document_checklist, attrs) do
    document_checklist
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
