defmodule FirstDaysWeb.ComponentHelpers do
  alias FirstDays.ComponentView

  def shared_component(template, assigns \\ []) do
    ComponentView.render(template, assigns)
  end

  # font classes

  def headline_font, do: "f3 lh-copy b black"
  def title_font, do: "f4 lh-copy"
  def title_black_font, do: "#{title_font()} black"
  def title_bold_font, do: "#{title_font()} b"
  def title_blue_font, do: "#{title_font()} b blue"
  def body_font, do: "f5 lh-copy black"
  def body_bold_font, do: "#{body_font()} b"
  def button_font_font, do: "f5 b white"
  def tab_white_font_font, do: "f6 white ttu"
  def tab_black_font_font, do: "f6 black ttu"

  def card_font, do: "bg-white pa4-ns pa3 _fontbr2 shadow-1"

  # form classes

  def input_class, do: "pa2 input-reset ba b--blue br2 bg-white measure f5 outline-0 w5"
  def input_label_class, do: "db b f5 lh-copy black mb2"
  def input_error_class, do: "db f6 red mt1"

end
