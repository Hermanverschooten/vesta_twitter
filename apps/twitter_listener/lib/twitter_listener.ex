defmodule TwitterListener do
  use GenServer
  require Logger

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :twitter)
  end

  def init(_opts) do
    ExTwitter.configure
    Logger.info "Configured ExTwitter"
    {:ok, %{}}
  end

  def follow(query, callback) do
    GenServer.cast(:twitter, {:start, query, callback})
  end

  def last_tweets(query, count) do
    ExTwitter.search(query, [count: count])
  end

  def handle_cast({:start, query, callback}, state) do
    state = case Map.get(state, :pid) do
      nil ->
        pid = spawn(fn ->
          stream = ExTwitter.stream_filter(track: query)
          for tweet <- stream do
            callback.(tweet)
          end
        end
        )
        Map.put(state, query, pid)
      _ -> state
    end
    {:noreply, state}
  end
end
