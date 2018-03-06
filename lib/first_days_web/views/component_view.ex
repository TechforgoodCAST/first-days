defmodule FirstDaysWeb.ComponentView do
  use FirstDaysWeb, :view

  def switch_locale_path(conn, locale, language) do
    "<a href=\"#{conn.request_path}?locale=#{locale}\">#{language}</a>" |> raw
  end
end
