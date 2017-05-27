use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :app, App.Endpoint,
  http: [port: 3333],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :app, App.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "magic",
  database: "app_dev",
  hostname: "192.168.33.100",
  pool_size: 10

config :app, :bigcommerce,
  api_url: "https://api.bigcommerce.com/",
  auth_url: "https://login.bigcommerce.com/oauth2/token",
  client_id: "d43zj85tiwn114mxsx4nnksa3wgmv5a",
  client_secret: "gsfs9wwkay7agvavnxpyeyj3vcotepg",
  redirect_uri: "https://f6d1d0cd.ngrok.io/app/install",
  http_client: Bigcommerce.HttpClient
