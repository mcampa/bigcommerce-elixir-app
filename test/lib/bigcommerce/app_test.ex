defmodule Bigcommerce.AppTest do
  use ExUnit.Case, async: true

  import Mock

  test "success authorize" do
    with_mock HTTPoison, [
      post: fn (_url, _body, _headers, _opts) ->
        {:ok, %HTTPoison.Response{status_code: 200, body: "{\"access_token\":\"123\",\"scope\":\"orders\"}"}}
      end
    ] do
      account = Bigcommerce.App.authorize("code", "scope", "context")

      assert account.access_token == "123"
      assert account.scope == "orders"
    end
  end

  test "fail authorize" do
    with_mock HTTPoison, [
      post: fn (_url, _body, _headers, _opts) ->
        {:ok, %HTTPoison.Response{status_code: 401, body: "{}"}}
      end
    ] do

      assert_raise RuntimeError, "Server responded with code 401 for https://login.bigcommerce.com/oauth2/token", fn ->
        Bigcommerce.App.authorize("code", "scope", "context")
      end
    end
  end

  test "decrypt a valid signed payload" do
    assert {:ok, data} = Bigcommerce.App.decrypt("eyJmb28iOiJiYXIifQ==.ZDY5ODMxYjhiYWU0YzJlNzlhNDlmMGQ1ZDRiOTNiNDg3NGYxMmY3MjJjM2JkOTgzN2FmNTEzZWZkNjZkYWJiNQ==")
    assert data["foo"] == "bar"
  end

  test "decrypt an invalid payload" do
    assert {:error, "Invalid payload"} == Bigcommerce.App.decrypt("eyJ==")
  end

  test "decrypt signature fail" do
    assert {:error, "Signature did not match"} == Bigcommerce.App.decrypt("eyJmb28iOiJiYXIifQ==.ZmFrZQ==")
  end
end

