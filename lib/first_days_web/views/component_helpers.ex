defmodule FirstDaysWeb.ComponentHelpers do
  alias FirstDays.ComponentView

  def shared_component(template, assigns \\ []) do
    ComponentView.render(template, assigns)
  end

  def card, do: "bg-white pa4-ns pa3 br2 shadow-1"
  def headline, do: "f3 lh-copy b black"
  def title, do: "f4 lh-copy"
  def title_black, do: "#{title()} black"
  def title_bold, do: "#{title()} b"
  def title_blue, do: "#{title()} b blue"
  def sub_header, do: "f5 lh-copy b black"
  def button_font, do: "f5 b white"
  def tab_white_font, do: "f6 white ttu"
  def tab_black_font, do: "f6 black ttu"
end
