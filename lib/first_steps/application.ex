defmodule FirstSteps.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(FirstSteps.Repo, []),
      # Start the endpoint when the application starts
      supervisor(FirstSteps.Web.Endpoint, []),
      # Start your own worker by calling: FirstSteps.Worker.start_link(arg1, arg2, arg3)
      # worker(FirstSteps.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FirstSteps.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
