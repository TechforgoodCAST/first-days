defmodule FirstDays.StateTest do
  use FirstDays.DataCase

  alias FirstDays.State

  describe "stages" do
    alias FirstDays.State.Stage

    @valid_attrs %{stage: "some stage"}
    @update_attrs %{stage: "some updated stage"}
    @invalid_attrs %{stage: nil}

    def stage_fixture(attrs \\ %{}) do
      {:ok, stage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> State.create_stage()

      stage
    end

    test "list_stages/0 returns all stages" do
      stage = stage_fixture()
      assert State.list_stages() == [stage]
    end

    test "get_stage!/1 returns the stage with given id" do
      stage = stage_fixture()
      assert State.get_stage!(stage.id) == stage
    end

    test "create_stage/1 with valid data creates a stage" do
      assert {:ok, %Stage{} = stage} = State.create_stage(@valid_attrs)
      assert stage.stage == "some stage"
    end

    test "create_stage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = State.create_stage(@invalid_attrs)
    end

    test "update_stage/2 with valid data updates the stage" do
      stage = stage_fixture()
      assert {:ok, stage} = State.update_stage(stage, @update_attrs)
      assert %Stage{} = stage
      assert stage.stage == "some updated stage"
    end

    test "update_stage/2 with invalid data returns error changeset" do
      stage = stage_fixture()
      assert {:error, %Ecto.Changeset{}} = State.update_stage(stage, @invalid_attrs)
      assert stage == State.get_stage!(stage.id)
    end

    test "delete_stage/1 deletes the stage" do
      stage = stage_fixture()
      assert {:ok, %Stage{}} = State.delete_stage(stage)
      assert_raise Ecto.NoResultsError, fn -> State.get_stage!(stage.id) end
    end

    test "change_stage/1 returns a stage changeset" do
      stage = stage_fixture()
      assert %Ecto.Changeset{} = State.change_stage(stage)
    end
  end
end
