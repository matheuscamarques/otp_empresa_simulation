defmodule Supervisor.Logistica do
    use Supervisor

    def start_link(start_numbers) do
      Supervisor.start_link(__MODULE__, start_numbers, name: Utils.factory_name(__MODULE__))
    end

    @impl true
    def init(start_numbers) do
      children =
      for start_number <- start_numbers do
        # We can't just use `{OurNewApp.Counter, start_number}`
        # because we need different ids for children

        Supervisor.child_spec({Specialist.Suporte, start_number}, id: UUID.uuid1())
      end

      Supervisor.init(children, strategy: :rest_for_one)
    end
  end
