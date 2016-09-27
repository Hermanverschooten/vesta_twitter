defmodule UserInterface.TweetsChannel do
  use UserInterface.Web, :channel

  def join("tweets:lobby", _payload, socket) do
    {:ok, socket}
  end
end
