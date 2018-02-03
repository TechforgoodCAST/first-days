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
    resources "/forgot-password", PasswordController, only: [:new, :create, :edit, :update]
  end

  scope "/forms", FirstDaysWeb do
    pipe_through [:browser, :authenticate_user]

    get "/role-description-new", RoleDescriptionController, :role_description_new
    post "/role-description-create", RoleDescriptionController, :role_description_create
    get "/role-description-show", RoleDescriptionController, :role_description_show
    get "/role-description-edit", RoleDescriptionController, :role_description_edit
    put "/role-description-update", RoleDescriptionController, :role_description_update

    get "/confirmation-agreement-show", ConfirmationAgreementController, :confirmation_agreement_show

    get "/document-checklist-new", DocumentChecklistController, :document_checklist_new
    post "/document-checklist-create", DocumentChecklistController, :document_checklist_create
    get "/document-checklist-show", DocumentChecklistController, :document_checklist_show
    get "/document-checklist-edit", DocumentChecklistController, :document_checklist_edit
    put "/document-checklist-update", DocumentChecklistController, :document_checklist_update

    get "/preparation-new", PreparationController, :preparation_new
    post "/preparation-create", PreparationController, :preparation_create
    get "/preparation-show", PreparationController, :preparation_show
    get "/preparation-edit", PreparationController, :preparation_edit
    put "/preparation-update", PreparationController, :preparation_update

    get "/feedback-show", FeedbackController, :feedback_show
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstDaysWeb do
  #   pipe_through :api
  # end
end
