defmodule Bigcommerce.App do

  def authorize(code, scope, context) do
    config = Application.get_env(:app, :bigcommerce) |> Enum.into(%{})

    body = %{
      client_id: config.client_id,
      client_secret: config.client_secret,
      grant_type: "authorization_code",
      redirect_uri: config.redirect_uri,
      code: code,
      scope: scope,
      context: context
    }

    case config.http_client.post(config.auth_url, body) do
      {:ok, response} ->
        %{
          access_token: response["access_token"],
          context: response["context"],
          scope: response["scope"],
          user: %{
            email: response["user"]["email"],
            user_id: response["user"]["id"],
            username: response["user"]["username"],
          },
        }
      {:error, reason} ->
        raise reason
    end
  end

  def decrypt(signed_payload) do
    config = Application.get_env(:app, :bigcommerce) |> Enum.into(%{})

    case Regex.run(~r/(.+?)\.(.+)/, signed_payload) do
      [_, payload, signature] ->
        signature = Base.decode64!(signature)
        json = Base.decode64!(payload)

        case :crypto.hmac(:sha256, config.client_secret, json) |> Base.encode16(case: :lower) do
          ^signature -> {:ok,  Poison.decode!(json)}
          _ -> {:error, "Signature did not match"}
        end
      _ -> {:error, "Invalid payload"}
    end
  end
end
