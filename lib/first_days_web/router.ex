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
    get "/first-days-index", PageController, :first_days_index
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/forms", FirstDaysWeb do
    pipe_through [:browser, :authenticate_user]

    get "/role-description-new", FormController, :role_description_new
    post "/role-description-create", FormController, :role_description_create
    get "/role-description-show", FormController, :role_description_show
    get "/role-description-edit", FormController, :role_description_edit
    put "/role-description-update", FormController, :role_description_update

    get "/confirmation-agreement-show", FormController, :confirmation_agreement_show

    get "/document-checklist-new", FormController, :document_checklist_new
    post "/document-checklist-create", FormController, :document_checklist_create
    get "/document-checklist-show", FormController, :document_checklist_show
    get "/document-checklist-edit", FormController, :document_checklist_edit
    put "/document-checklist-update", FormController, :document_checklist_update

    get "/preparation-new", FormController, :preparation_new
    post "/preparation-create", FormController, :preparation_create
    get "/preparation-show", FormController, :preparation_show
    get "/preparation-edit", FormController, :preparation_edit
    put "/preparation-update", FormController, :preparation_update
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstDaysWeb do
  #   pipe_through :api
  # end
end
