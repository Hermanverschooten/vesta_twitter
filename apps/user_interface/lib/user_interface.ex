defmodule UserInterface do
  use Application
  require Logger

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(UserInterface.Endpoint, []),
      worker(TwitterListener, []),
      # Start your own worker by calling: UserInterface.Worker.start_link(arg1, arg2, arg3)
      # worker(UserInterface.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UserInterface.Supervisor]
    result = Supervisor.start_link(children, opts)

    TwitterListener.follow Application.get_env(:twitter_listener, :tweets), fn(tweet) ->
      UserInterface.Endpoint.broadcast("tweets:lobby", "tweet", tweet)
    end
    result
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    UserInterface.Endpoint.config_change(changed, removed)
    :ok
  end
end
