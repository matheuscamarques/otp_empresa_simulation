defmodule Setor.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do


    children = [
      Supervisor.child_spec({Supervisor.Geral,name: Supervisor.Geral.PR}, id: UUID.uuid1()),
      Supervisor.child_spec({Supervisor.Geral,name: Supervisor.Geral.BA}, id: UUID.uuid1()),
      Supervisor.child_spec({Supervisor.Geral,name: Supervisor.Geral.BH}, id: UUID.uuid1())
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Appication.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
