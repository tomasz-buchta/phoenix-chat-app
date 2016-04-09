defmodule ChatApp.MessageController do
  use ChatApp.Web, :controller

  alias ChatApp.Message

  def index(conn, _params) do
    messages = Repo.all(Message)
    render(conn, "index.html", messages: messages)
  end
end
