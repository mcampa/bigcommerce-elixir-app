defmodule Requester do

  def get({client_id, token}, url, headers \\ []) do
    url = String.to_char_list(url)
    headers = headers ++ auth_header({client_id, token})
    :httpc.request(:get, {url, headers}, [], [])
    |> parse_response
  end

  def post({client_id, token}, url, body, headers \\ []) do
    url = String.to_char_list(url)
    ctype = 'application/x-www-form-urlencoded'
    headers = headers ++ auth_header({client_id, token})

    :httpc.request(:post, {url, headers, ctype, body}, [], body_format: :binary)
    |> parse_response
  end

  def auth_header({client_id, token}) do
    [
      {'Content-Type', 'application/json'},
      {'Accept', 'application/json'},
      {'X-Auth-Client', client_id},
      {'X-Auth-Token', token},
    ]
  end

  defp parse_response(response) do
    case response do
      {:ok, {{_httpvs, 200, _status_phrase}, json_body}} ->
        {:ok, Poison.decode!(json_body)}
      {:ok, {{_httpvs, 201, _status_phrase}, json_body}} ->
        {:ok, Poison.decode!(json_body)}
      {:ok, {{_httpvs, 200, _status_phrase}, _headers, json_body}} ->
        {:ok, Poison.decode!(json_body)}
      {:ok, {{_httpvs, 201, _status_phrase}, _headers, json_body}} ->
        {:ok, Poison.decode!(json_body)}
      {:ok, {{_httpvs, status, _status_phrase}, json_body}} ->
        {:error, status, Poison.decode!(json_body)}
      {:ok, {{_httpvs, status, _status_phrase}, _headers, json_body}} ->
        {:error, status, Poison.decode!(json_body)}
      {:error, reason} ->
        {:error, :bad_fetch, reason}
    end
  end
end
