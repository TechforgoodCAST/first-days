defmodule FirstDays.UserData.Answer do
  use Ecto.Schema
  import Ecto.Changeset
  alias FirstDays.{UserData.Answer, Accounts.User, State.Stage}


  schema "answers" do
    field :answers, :map
    belongs_to :user, User
    belongs_to :stage, Stage

    timestamps()
  end

  @service_quote_error_message "There are already answers for that use                                        r"

  @doc false
  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:answers])
    |> unique_constraint(:unique_user_stage_pair, name: :unique_user_stage_pair, message: @user_stage_error_message)
    |> validate_required([:answers])
  end
end
