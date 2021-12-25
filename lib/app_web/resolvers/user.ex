defmodule AppWeb.Resolver.User do
  alias App.User
  import Ecto.Query

  def profile(_root, args, _ctx) do
    if is_nil(args[:name]) do
      {:ok, nil}
    else
      query = from(a in User, where: a.name == ^args[:name])

      user = query |> App.Repo.one()

      case user do
        nil -> User.create(%{name: args[:name]})
        %User{} -> {:ok, user}
      end
    end
  end

  def list(_root, _args, _ctx) do
    users = User |> App.Repo.all()
    IO.inspect(users)
    {:ok, User |> App.Repo.all()}
  end
end
