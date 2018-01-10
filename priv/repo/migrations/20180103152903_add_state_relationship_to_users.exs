defmodule FirstDays.Repo.Migrations.AddStateRelationshipToUsers do
  use Ecto.Migration

  def change do
    alter table ("users") do
      add :stage_id, references(:stages, on_delete: :nothing)
    end
  end
end
