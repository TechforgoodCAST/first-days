defmodule FirstDaysWeb.ComponentHelpers do
  alias FirstDays.ComponentView

  def shared_component(template, assigns \\ []) do
    ComponentView.render(template, assigns)
  end
end
