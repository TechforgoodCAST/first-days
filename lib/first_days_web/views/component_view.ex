defmodule FirstDaysWeb.ComponentView do
  use FirstDaysWeb, :view

  def switch_locale_path(conn, locale, language) do
    "<a href=\"#{page_path(conn, :index, locale: locale)}\">#{language}</a>" |> raw
  end
end
