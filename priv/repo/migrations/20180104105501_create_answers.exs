defmodule FirstDays.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :role_description, :map
      add :document_checklist, :map
      add :preparation, :map
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:answers, [:user_id])
  end
end
