defmodule Adeunis.Register.KeepAliveTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.KeepAlive

  test "decode/1" do
    assert %KeepAlive{period: 30} = KeepAlive.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.keep_alive() do
      assert register ==
               register
               |> KeepAlive.encode()
               |> KeepAlive.decode()
    end
  end
end
