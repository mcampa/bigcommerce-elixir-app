defmodule App.User do
  use App.Web, :model

  schema "users" do
    field :user_id, :string
    field :context, :string
    field :token, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :context, :token])
    |> validate_required([:user_id, :context, :token])
  end
end
