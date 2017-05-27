defmodule App.InstallControllerTest do
  use App.ConnCase

  import Mock

  test "GET /app/install", %{conn: conn} do
    with_mock HTTPoison, [
      post: fn (_url, _body, _headers, _opts) ->
        {:ok, %HTTPoison.Response{status_code: 200, body: "{}"}}
      end
    ] do

      conn = get conn, "/app/install?code=lb7en3oz4c&scope=users_basic_information&context=stores/gyfoori"
      assert html_response(conn, 200)
    end
  end
end
