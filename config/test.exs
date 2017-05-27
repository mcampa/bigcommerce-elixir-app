use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :app, App.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :app, App.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "magic",
  database: "app_dev",
  hostname: "192.168.33.100",
  pool: Ecto.Adapters.SQL.Sandbox


config :app, :bigcommerce,
  api_url: "https://api.bigcommerce.com/",
  auth_url: "https://login.bigcommerce.com/oauth2/token",
  client_id: "d43zj85tiwn114mxsx4nnksa3wgmv5a",
  client_secret: "gsfs9wwkay7agvavnxpyeyj3vcotepg",
  redirect_uri: "https://f6d1d0cd.ngrok.io/app/install",
  http_client: Bigcommerce.HttpClient
