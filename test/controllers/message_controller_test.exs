defmodule ChatApp.MessageControllerTest do
  use ChatApp.ConnCase

  alias ChatApp.Message
  @valid_attrs %{content: "some content"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, message_path(conn, :index)
    assert html_response(conn, 200) =~ "Messages"
  end
end
