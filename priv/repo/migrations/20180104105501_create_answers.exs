defmodule FirstDays.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answers, :map, null: false
      add :stage_id, references(:stages, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:answers, [:stage_id])
    create index(:answers, [:user_id])
    create unique_index(:answers, [:stage_id, :user_id], name: :unique_user_stage_pair)
  end
end
