defmodule Utils do
  def factory_name(name) do
    uuid = UUID.uuid1
    String.to_atom("#{name}_#{uuid}")
  end
end
