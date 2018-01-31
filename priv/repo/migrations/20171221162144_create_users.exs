defmodule FirstDays.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :password_hash, :string, null: false
      add :role_description, :map
      add :document_checklist, :map
      add :preparation, :map

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
