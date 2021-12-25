defmodule App.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :title, :string, null: false
      add :description, :string, null: false
      add :done, :boolean, null: false
      add :color, :string, null: false

      timestamps()
    end
  end
end
