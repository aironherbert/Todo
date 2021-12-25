defmodule AppWeb.Resolver.Todo do
  alias App.Todo

  def list_by(_root, args, _ctx) do
    {:ok, Todo.list_by(args[:name])}
  end

  def list(_root, _args, _ctx) do
    {:ok, Todo.list()}
  end

  def create(_root, args, _ctx) do
    case Todo.create(args) do
      {:ok, todo} -> {:ok, todo}
      _error -> {:error, "Could not create todo!"}
    end
  end

  def change(_root, args, _ctx) do
    case Todo.change(args) do
      {:ok, todo} -> {:ok, todo}
      _error -> {:error, "Could not change todo!"}
    end
  end

  def delete(_root, args, _ctx) do
    case Todo.delete(args) do
      {:ok, todo} -> {:ok, todo}
      _error -> {:error, "Could not delete todo!"}
    end
  end

  def done(_root, args, _ctx) do
    case Todo.done(args) do
      {:ok, todo} -> {:ok, todo}
      _error -> {:error, "Could not done todo!"}
    end
  end

  def undone(_root, args, _ctx) do
    case Todo.undone(args) do
      {:ok, todo} -> {:ok, todo}
      _error -> {:error, "Could not undone todo!"}
    end
  end
end
