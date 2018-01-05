defmodule FirstDays.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :answers, :map
      add :stage_id, references(:stages, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:stage_id])
    create index(:answers, [:user_id])
  end
end
