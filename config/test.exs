use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chat_app, ChatApp.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :chat_app, ChatApp.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "phoenix",
  password: "phoenix",
  database: "chat_app_test",
  hostname: "172.17.02",
  pool: Ecto.Adapters.SQL.Sandbox
