defmodule FirstDays.UserDataTest do
  use FirstDays.DataCase

  alias FirstDays.UserData

  describe "answers" do
    alias FirstDays.UserData.Answer

    @valid_attrs %{answer: %{}}
    @update_attrs %{answer: %{}}
    @invalid_attrs %{answer: nil}

    def answer_fixture(attrs \\ %{}) do
      {:ok, answer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> UserData.create_answer()

      answer
    end

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert UserData.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert UserData.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      assert {:ok, %Answer{} = answer} = UserData.create_answer(@valid_attrs)
      assert answer.answer == %{}
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = UserData.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      assert {:ok, answer} = UserData.update_answer(answer, @update_attrs)
      assert %Answer{} = answer
      assert answer.answer == %{}
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = UserData.update_answer(answer, @invalid_attrs)
      assert answer == UserData.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = UserData.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> UserData.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = UserData.change_answer(answer)
    end
  end
end
