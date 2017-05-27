defmodule App.AppController do
  use App.Web, :controller

  def index(conn, _params) do
    {:ok, account} = Bigcommerce.App.decrypt(conn.query_params["signed_payload"])

    IO.inspect account

    json conn, %{"data" => account}
  end
end
