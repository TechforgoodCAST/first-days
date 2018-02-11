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

  pipeline :signed_out_layout do
    plug :put_layout, {FirstDaysWeb.LayoutView, :signed_out_layout}
  end

  scope "/", FirstDaysWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/landing", PageController, :landing
    get "/get-them-ready", PageController, :get_them_ready
    get "/test", PageController, :test

    post "/update-stage", StageController, :update_stage

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
    get "/role-description-email", RoleDescriptionController, :role_description_email

    get "/confirmation-agreement-show", ConfirmationAgreementController, :confirmation_agreement_show
    get "/confirmation-agreement-email", ConfirmationAgreementController, :confirmation_agreement_email

    get "/document-checklist-new", DocumentChecklistController, :document_checklist_new
    post "/document-checklist-create", DocumentChecklistController, :document_checklist_create
    get "/document-checklist-show", DocumentChecklistController, :document_checklist_show
    get "/document-checklist-edit", DocumentChecklistController, :document_checklist_edit
    put "/document-checklist-update", DocumentChecklistController, :document_checklist_update
    get "/document_checklist-email", DocumentChecklistController, :document_checklist_email

    get "/preparation-new", PreparationController, :preparation_new
    post "/preparation-create", PreparationController, :preparation_create
    get "/preparation-show", PreparationController, :preparation_show
    get "/preparation-edit", PreparationController, :preparation_edit
    put "/preparation-update", PreparationController, :preparation_update
    get "/preparation-email", PreparationController, :preparation_email

    get "/feedback-show", FeedbackController, :feedback_show
    get "/feedback-email", FeedbackController, :feedback_email
  end

  # Other scopes may use custom stacks.
  # scope "/api", FirstDaysWeb do
  #   pipe_through :api
  # end
end
