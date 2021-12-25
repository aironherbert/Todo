defmodule AppWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :todo do
    field(:id, non_null(:integer))
    field(:user_id, non_null(:integer))
    field(:title, non_null(:string))
    field(:description, non_null(:string))
    field(:color, non_null(:string))
    field(:done, non_null(:boolean))
    field(:inserted_at, :naive_datetime)
    field(:updated_at, :naive_datetime)
  end

  object :user do
    field(:id, non_null(:integer))
    field(:name, non_null(:string))

    field(:todos, list_of(:todo), resolve: dataloader(App.Todo))

    field(:inserted_at, :time)
    field(:updated_at, :time)
  end

  query do
    field :todos, non_null(list_of(non_null(:todo))) do
      resolve(&AppWeb.Resolver.Todo.list/3)
    end

    field :users, non_null(list_of(non_null(:user))) do
      resolve(&AppWeb.Resolver.User.list/3)
    end

    field :profile, :user do
      arg(:name, :string)
      resolve(&AppWeb.Resolver.User.profile/3)
    end
  end

  mutation do
    field :create_todo, non_null(:todo) do
      arg(:user_id, non_null(:integer))
      arg(:title, non_null(:string))
      arg(:description, non_null(:string))
      arg(:color, non_null(:string))
      arg(:done, :boolean)
      resolve(&AppWeb.Resolver.Todo.create/3)
    end

    field :update_todo, non_null(:todo) do
      arg(:id, non_null(:integer))
      arg(:title, :string)
      arg(:description, :string)
      arg(:color, :string)
      arg(:done, :boolean)
      resolve(&AppWeb.Resolver.Todo.change/3)
    end

    field :delete_todo, non_null(:todo) do
      arg(:id, non_null(:integer))
      resolve(&AppWeb.Resolver.Todo.delete/3)
    end

    field :done, non_null(:todo) do
      arg(:id, non_null(:integer))
      resolve(&AppWeb.Resolver.Todo.done/3)
    end

    field :undone, non_null(:todo) do
      arg(:id, non_null(:integer))
      resolve(&AppWeb.Resolver.Todo.undone/3)
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(App.Todo, App.Todo.data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
