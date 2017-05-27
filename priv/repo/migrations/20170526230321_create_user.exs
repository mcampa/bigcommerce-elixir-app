defmodule App.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :user_id, :string
      add :context, :string
      add :token, :string

      timestamps()
    end

  end
end
