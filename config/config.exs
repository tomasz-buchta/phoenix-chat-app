# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :chat_app, ChatApp.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "tJF3CnEGq8moGpxdvJLgJSkVBZxaaccKPmZHcdvAotrdO2TM+IUj8Y2sG3+Mp955",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ChatApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

config :guardian, Guardian,
  issuer: "ChatApp",
  ttl: { 3, :days },
  verify_issuer: true,
  secret_key: "asdfasf43f434f43f34",
  serializer: PhoenixTrello.GuardianSerializer
