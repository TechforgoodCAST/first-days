defmodule FirstDays.Repo.Migrations.CreateStages do
  use Ecto.Migration

  def change do
    create table(:stages) do
      add :stage, :string
    end
  end
end
