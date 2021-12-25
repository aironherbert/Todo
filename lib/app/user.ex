defmodule App.User do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias App.Repo

  schema "users" do
    field(:name, :string)
    has_many(:todos, App.Todo)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name])
  end

  def create(params) do
    %App.User{}
    |> changeset(params)
    |> validate_required(:name)
    |> Repo.insert()
  end

  def insert_todo(user, todo) do
    user
    |> change()
    |> put_assoc(:todos, [todo | user.todos])
    |> Repo.update()
  end

  def update(params) do
    todo = Repo.get(App.User, params[:id])

    todo
    |> changeset(params)
    |> Repo.update()
  end

  def delete(%{id: id}) do
    todo = Repo.get(App.User, id)

    todo
    |> Repo.delete()
  end

  def list() do
    query = from(a in App.User, order_by: [desc: a.inserted_at])

    query
    |> Repo.all()
  end
end
