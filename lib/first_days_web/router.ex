defmodule FirstDaysWeb.Router do
  use FirstDaysWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug FirstDaysWeb.Auth, repo: FirstDays.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", FirstDaysWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/forms", FirstDaysWeb do
    pipe_through :browser

    get "/role-description", FormController, :role_description
    get "/confirmation-agreement", FormController, :confirmation_agreement
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstDaysWeb do
  #   pipe_through :api
  # end
end
