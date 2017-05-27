defmodule App.InstallController do
  use App.Web, :controller

  def install(conn, _params) do
    case conn.query_params do
      %{"code" => code, "context" => context, "scope" => scope} ->
        client = Bigcommerce.App.authorize(code, scope, context)
                  |> save_account
                  |> Bigcommerce.Api.client

        # subscribe to webhooks
        Bigcommerce.Webhooks.subscribe(client)

        # start jwt session
        # TODO

        render conn, "index.html"
      _ -> render conn, "404.html"
    end
  end

  def uninstall(conn, _params) do
    render conn, "index.html"
  end

  defp save_account(account) do
    IO.puts "Installing account"
    IO.inspect account
    account
  end
end
