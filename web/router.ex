defmodule ChatApp.Router do
  use ChatApp.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_session do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ChatApp do
    pipe_through [:browser, :browser_session]

    get "/login", SessionController, :new, as: :login
    post "/login", SessionController, :create, as: :login
    delete "/logout", SessionController, :delete, as: :logout
    get "/logout", SessionController, :delete, as: :logout

    get "/", PageController, :index
    resources "/users", UserController
    get "/messages", MessageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", ChatApp do
  #   pipe_through :api
  # end
end
