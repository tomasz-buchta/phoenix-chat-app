defmodule ChatApp.SessionController do
  use ChatApp.Web, :controller

  alias ChatApp.User

  def new(conn, _params) do
    changeset = User.login_changeset(%User{})
    render(conn, "new.html", changeset: changeset, action: nil)
  end

  def create(conn, %{"user" => user_params}) do
    user = if is_nil(user_params["email"]) do
      nil
    else
      Repo.get_by(User, email: user_params["email"])
    end

    user
      |> sign_in(user_params["password"],conn)
  end

  def delete(conn, _params) do
    Guardian.Plug.sign_out(conn)
    |> put_flash(:info, "Logged out successfully.")
    |> redirect(to: "/")
  end

  defp sign_in(user, _password, conn) when is_nil(user) do
    conn
      |> put_flash(:error, 'Could not find a user with that username.')
      |> render("new.html", changeset: User.changeset(%User{}), action: nil)
  end

  defp sign_in(user, password, conn) when is_map(user) do
    cond do
      Comeonin.Bcrypt.checkpw(password, user.encrypted_password) ->
        conn
          |> Guardian.Plug.sign_in(user)
          |> put_flash(:info, 'You are now signed in.')
          |> redirect(to: page_path(conn, :index))
      true ->
        conn
          |> put_flash(:error, 'Username or password are incorrect.')
          |> render("new.html", changeset: User.changeset(%User{}), action: nil)
    end
  end
end
