# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Lift.Repo.insert!(%Lift.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Lift.Repo.delete_all Lift.User

Lift.User.changeset(%Lift.User{}, %{name: "John Marks", email: "john@marks.com", password: "secret", password_confirmation: "secret"})
|> Lift.Repo.insert!
