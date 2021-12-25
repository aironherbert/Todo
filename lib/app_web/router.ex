defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL, schema: AppWeb.Schema

    forward "/", Absinthe.Plug, schema: AppWeb.Schema
  end
end
