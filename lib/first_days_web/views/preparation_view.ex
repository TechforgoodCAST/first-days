defmodule FirstDaysWeb.PreparationView do
  use FirstDaysWeb, :view

  def my_datetime_select(form, field, opts \\ []) do
    builder = fn b ->
      ~e"""
      <%= b.(:day, [ class: "form-control" ]) %> / <%= b.(:month, [ class: "form-control" ]) %> / <%= b.(:year, [ class: "form-control" ]) %>
      """
    end

    date_select(form, field, [builder: builder] ++ opts)
  end
end
