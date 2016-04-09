defmodule ChatApp.RoomChannelTest do
  use ChatApp.ChannelCase
  import Ecto.Query

  alias ChatApp.RoomChannel
  alias ChatApp.Message

  setup do
    {:ok, _, socket} =
      socket("user_id", %{some: :assign})
      |> subscribe_and_join(RoomChannel, "rooms:lobby")

    {:ok, socket: socket}
  end

  test "ping replies with status ok", %{socket: socket} do
    ref = push socket, "ping", %{"content" => "sample content"}
    assert_reply ref, :ok, %{"content" => "sample content"}
  end

  test "shout broadcasts to rooms:lobby", %{socket: socket} do
    push socket, "shout", %{"content" => "sample content"}
    assert_broadcast "shout", %{"content" => "sample content"}
  end

  test "shout saves the message", %{socket: socket} do
    ref = push socket, "shout", %{content: "sample content"}
    assert_reply ref, :ok
    assert Repo.get_by(Message, content: "sample content")
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from! socket, "broadcast", %{"some" => "data"}
    assert_push "broadcast", %{"some" => "data"}
  end
end
