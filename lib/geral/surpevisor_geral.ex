defmodule Supervisor.Geral do
    use Supervisor

    def start_link(opts) do
      Supervisor.start_link(__MODULE__, :ok, opts)
    end

    @impl true
    def init(:ok) do
      children = [
          {Supervisor.Suporte, [1000,2000,3000,4000,5000] } ,
          {Supervisor.Ti, [1000,2000,3000,4000,5000]},
          {Supervisor.Logistica, [1000,2000,3000,4000,5000]}
      ]

      Supervisor.init(children, strategy: :one_for_one)
    end
  end
