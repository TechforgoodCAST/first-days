# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FirstDays.Repo.insert!(%FirstDays.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias FirstDays.{State.Stage, Repo}
alias Ecto.Multi

stages =
  Stage.stages()
  |> Enum.map(fn x -> %{stage: x} end)

Multi.new
|> Multi.insert_all(:add_stages, Stage, stages)
|> Repo.transaction
