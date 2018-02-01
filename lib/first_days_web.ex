defmodule FirstDaysWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use FirstDaysWeb, :controller
      use FirstDaysWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: FirstDaysWeb
      import Plug.Conn
      import FirstDaysWeb.Router.Helpers
      import FirstDaysWeb.Gettext
      import FirstDaysWeb.Auth, only: [authenticate_user: 2] # New import
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "lib/first_days_web/templates",
                        namespace: FirstDaysWeb

      # Import convenience functions from controllers
      import Phoenix.Controller, only: [get_flash: 2, view_module: 1]

      # Use all HTML functionality (forms, tags, etc)
      use Phoenix.HTML

      import FirstDaysWeb.Router.Helpers
      import FirstDaysWeb.ErrorHelpers
      import FirstDaysWeb.Gettext
      import FirstDaysWeb.ComponentHelpers
    end
  end

  def router do
    quote do
      use Phoenix.Router
      import Plug.Conn
      import Phoenix.Controller
      import FirstDaysWeb.Auth, only: [authenticate_user: 2] # New import
    end
  end

  def channel do
    quote do
      use Phoenix.Channel
      import FirstDaysWeb.Gettext
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
