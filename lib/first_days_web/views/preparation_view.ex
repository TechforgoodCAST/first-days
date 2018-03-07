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

  def digitsToMonth(1), do: gettext("January")
  def digitsToMonth(2), do: gettext("February")
  def digitsToMonth(3), do: gettext("March")
  def digitsToMonth(4), do: gettext("April")
  def digitsToMonth(5), do: gettext("May")
  def digitsToMonth(6), do: gettext("June")
  def digitsToMonth(7), do: gettext("July")
  def digitsToMonth(8), do: gettext("August")
  def digitsToMonth(9), do: gettext("September")
  def digitsToMonth(10), do: gettext("October")
  def digitsToMonth(11), do: gettext("November")
  def digitsToMonth(12), do: gettext("December")
end
