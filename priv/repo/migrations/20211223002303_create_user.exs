defmodule App.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string, null: false)

      timestamps()
    end

    alter table(:todos) do
      add(:user_id, references(:users))
    end
  end
end
