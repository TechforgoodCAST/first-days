# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :first_steps,
  ecto_repos: [FirstSteps.Repo]

# Configures the endpoint
config :first_steps, FirstSteps.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Na5pLcvdqJ5AlAYH6+jd8pQ9r3iJ069YnjkmNvsOTdkJTdPq0R+FKFmcnyhRoy6c",
  render_errors: [view: FirstSteps.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: FirstSteps.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# config for email service
config :first_steps, FirstSteps.Mailer,
  adapter: Bamboo.MailgunAdapter,
  api_key: System.get_env("MAILGUN_KEY"),
  domain: System.get_env("MAILGUN_DOMAIN")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
