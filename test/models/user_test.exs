defmodule ChatApp.UserTest do
  use ChatApp.ModelCase

  alias ChatApp.User

  @valid_attrs %{email: "john@sample.com", password: "123d12d3d", first_name: "some content", last_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "validate email format" do
    changeset = User.changeset(%User{}, %{@valid_attrs | :email => "invalid_email"})
    refute changeset.valid?
  end

  test "validate length" do
    changeset = User.changeset(%User{}, %{@valid_attrs | :password => "1234"})
    refute changeset.valid?
  end

#  TODO: add these tests
#  test "validate confirmation" do
#
#  end
#
#  test "validate uniqueness" do
#
#  end
end
