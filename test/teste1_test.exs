defmodule Teste1Test do
  use ExUnit.Case
  doctest Teste1

  test "greets the world" do
    assert Teste1.hello() == :world
  end
end
