defmodule FirstDaysWeb.Plugs.Locale do
  import Plug.Conn

  @locales Gettext.known_locales(FirstDaysWeb.Gettext)

  def init(_opts), do: nil

  def call(conn, _opts) do
    case locale_from_params(conn) || locale_from_cookies(conn) do
      nil ->
        conn
      locale ->
        Gettext.put_locale(FirstDaysWeb.Gettext, locale)
        conn |> persist_locale(locale)
    end
  end

  defp locale_from_params(conn) do
    conn.params["locale"] |> validate_locale
  end

  defp locale_from_cookies(conn) do
    conn.cookies["locale"] |> validate_locale
  end

  defp validate_locale(locale) when locale in @locales, do: locale
  defp validate_locale(_locale), do: nil

  defp persist_locale(conn, new_locale) do
    if conn.cookies["locale"] != new_locale do
      conn |> put_resp_cookie("locale", new_locale, max_age: 360*24*60*60)
    else
      conn
    end
  end
end
