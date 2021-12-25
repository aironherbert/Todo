defmodule App.Todo do
  use Ecto.Schema
  import Ecto.Query
  import Ecto.Changeset

  alias App.Repo

  schema "todos" do
    field(:title, :string)
    field(:description, :string)
    field(:done, :boolean)
    field(:color, :string)

    belongs_to(:user, App.User)

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:title, :description, :color, :done, :user_id])
  end

  def create(params) do
    %App.Todo{}
    |> changeset(params)
    |> validate_required(:user_id)
    |> validate_required(:title)
    |> validate_required(:color)
    |> validate_required(:done)
    |> validate_required(:description)
    |> Repo.insert()
  end

  def change(params) do
    todo = Repo.get(App.Todo, params[:id])

    todo
    |> changeset(params)
    |> Repo.update()
  end

  def delete(%{id: id}) do
    todo = Repo.get(App.Todo, id)

    todo
    |> Repo.delete()
  end

  def list() do
    query = from(a in App.Todo, order_by: [desc: a.inserted_at])

    query
    |> Repo.all()
  end

  def list_by(name) do
    user = App.User |> Repo.get_by(%{name: name})

    query = from(a in App.Todo, where: a.user_id == ^user.id)

    query
    |> Repo.all()
  end

  def done(params) do
    todo = Repo.get(App.Todo, params[:id])

    todo
    |> cast(params, %{done: true}, [:done])
    |> Repo.update()
  end

  def undone(params) do
    todo = Repo.get(App.Todo, params[:id])

    todo
    |> cast(params, %{done: false}, [:done])
    |> Repo.update()
  end
end
