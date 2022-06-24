defmodule App do

  def mapa_de_supervisores(supervisor_geral) do
    [logistica_child,ti_child,suporte_child] = supervisor_geral
                               |> Supervisor.which_children

    { _,logistica, _ , _ } = logistica_child
    { _,ti, _ , _ }        = ti_child
    { _,suporte, _ , _ }   = suporte_child

    %{
      logistica: logistica,
      ti: ti,
      suporte: suporte
    }

  end


  def list_especialist_from(supervisor) do
    supervisor
    |> Supervisor.which_children()
    |> Enum.map(fn {_ ,especialist, _,_ } ->
        especialist
    end)

  end

  def polling_especialist(especialists) do
       especialist =  Enum.random(especialists)
       {:status, status} = especialist
            |> Process.info(:status)

       case status do
          :waiting -> especialist
          _ -> polling_especialist(especialists)
       end
  end


  def get_especialist_from(:logistica, :PR) do
    supervisores = mapa_de_supervisores(Supervisor.Geral.PR)
    supervisores.logistica
      |> list_especialist_from()
      |> polling_especialist()
  end

  def get_especialist_from(:logistica, :BA) do
    supervisores = mapa_de_supervisores(Supervisor.Geral.BA)
    supervisores.logistica
      |> list_especialist_from()
      |> polling_especialist()
  end

  def get_especialist_from(:logistica, :BH) do
    supervisores = mapa_de_supervisores(Supervisor.Geral.BH)
    supervisores.logistica
      |> list_especialist_from()
      |> polling_especialist()
  end


  def brute_force(type, location) do
    App.get_especialist_from(type, location)
    |> Specialist.Logistica.run

    IO.puts("Preciso de um especialista de #{type} no #{location}")
    Process.sleep(500)
    brute_force(type, location)
  end

  def start() do
    spawn(App, :brute_force, [:logistica, :PR])
    spawn(App, :brute_force, [:logistica, :BA])
    spawn(App, :brute_force, [:logistica, :BH])
  end

end
