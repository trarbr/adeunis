defmodule Adeunis.Register.KeepAliveTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.KeepAlive

  test "decode/1 can decode any valid keep alive register" do
    assert %KeepAlive{period: 30} = KeepAlive.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.keep_alive() do
      assert frame ==
               frame
               |> KeepAlive.encode()
               |> KeepAlive.decode()
    end
  end
end
