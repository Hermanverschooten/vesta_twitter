defmodule UserInterface.PageController do
  use UserInterface.Web, :controller
  require Logger

  def index(conn, _params) do
    tweets = TwitterListener.last_tweets(Application.get_env(:twitter_listener, :tweets), 10)
    render conn, "index.html", tweets: tweets
  end
end
