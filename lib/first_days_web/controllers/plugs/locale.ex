defmodule FirstDaysWeb.Plugs.Locale do

  @locales Gettext.known_locales(FirstDaysWeb.Gettext)

  def init(_opts), do: nil

  def call(%Plug.Conn{params: %{"locale" => locale}} = conn, _opts) when locale in @locales do
    Gettext.put_locale(FirstDaysWeb.Gettext, locale)
    conn
  end

  def call(conn, _opts), do: conn
end
