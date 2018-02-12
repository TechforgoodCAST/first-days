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

  def digitsToMonth(1), do: "January"
  def digitsToMonth(2), do: "February"
  def digitsToMonth(3), do: "March"
  def digitsToMonth(4), do: "April"
  def digitsToMonth(5), do: "May"
  def digitsToMonth(6), do: "June"
  def digitsToMonth(7), do: "July"
  def digitsToMonth(8), do: "August"
  def digitsToMonth(9), do: "September"
  def digitsToMonth(10), do: "October"
  def digitsToMonth(11), do: "November"
  def digitsToMonth(12), do: "December"
end
