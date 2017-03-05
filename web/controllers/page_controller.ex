defmodule Lift.PageController do
  use Lift.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
