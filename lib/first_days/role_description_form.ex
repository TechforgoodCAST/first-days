defmodule FirstDays.RoleDescriptionForm do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.RoleDescriptionForm

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

  @doc false
  def changeset(%RoleDescriptionForm{} = role_description_form, attrs) do
    role_description_form
    |> cast(attrs, [:description, :area, :finance_skills, :work_frequency, :work_length, :location, :contact_details, :organisation_mission, :organisation_achievements, :charity_number, :website_link, :how_will_work_help, :skills_to_be_gained])
    |> validate_required([:description, :area, :finance_skills, :work_frequency, :work_length, :location, :contact_details, :organisation_mission, :organisation_achievements, :charity_number, :website_link, :how_will_work_help, :skills_to_be_gained])
  end
end
