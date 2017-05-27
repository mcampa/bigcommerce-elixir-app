defmodule Bigcommerce.HttpClient do
  def post(url, payload, headers \\ []) do
    {:ok, body} = Poison.encode(payload)

    headers = [
      {"Content-type", "application/json"},
      {"Accept", "application/json"}
    ] ++ headers

    case HTTPoison.post(url, body, headers, []) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
      {:ok, %HTTPoison.Response{status_code: code}} ->
        {:error, "Server responded with code #{code} for #{url}"}
      {:error, reason} -> {:error, reason}
    end
  end
end
