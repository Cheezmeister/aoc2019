defmodule Aoc2019Web.PageController do
  use Aoc2019Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
