defmodule FirstDaysWeb.PreparationView do
  use FirstDaysWeb, :view

  def my_datetime_select(form, field, opts \\ []) do
    opts =
      Keyword.put(opts, :month, options: [
        {gettext("January"), "1"},
        {gettext("February"), "2"},
        {gettext("March"), "3"},
        {gettext("April"), "4"},
        {gettext("May"), "5"},
        {gettext("June"), "6"},
        {gettext("July"), "7"},
        {gettext("August"), "8"},
        {gettext("September"), "9"},
        {gettext("October"), "10"},
        {gettext("November"), "11"},
        {gettext("December"), "12"},
      ])
      
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
