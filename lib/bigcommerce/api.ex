defmodule Bigcommerce.Api do
  def client(account) do
      %{account: account}
  end

  def get_url(uri) do
    (Application.get_env(:app, :bigcommerce) |> Keyword.get(:api_url)) <> uri
  end

  # def headers do
  #   [
  #     {"Content-Type", "application/json"},
  #     {"Accept", "application/json"},
  #     {"X-Auth-Client", config.client_id},
  #     {"X-Auth-Token", token},
  #   ]
  # end
end
