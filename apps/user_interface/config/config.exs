# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :user_interface, UserInterface.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/SDAyF0DzZmuVwhCuq1IQAoY4sXwHNOGVJRJnjgIy2AnQBMiPZvfa4DuOKoU06hf",
  render_errors: [view: UserInterface.ErrorView, accepts: ~w(html json)],
  pubsub: [name: UserInterface.PubSub,
           adapter: Phoenix.PubSub.PG2]
config :twitter_listener,
  tweets: "#campusvesta OR @campusvesta OR #VestaAcademy OR @VestaAcademy"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
