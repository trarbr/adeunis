defmodule Adeunis.Frame.KeepAliveTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.KeepAlive
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %KeepAlive{
             status: %Status{}
           } = KeepAlive.decode(<<0x30, 0x22>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.keep_alive() do
      assert frame ==
               frame
               |> KeepAlive.encode()
               |> KeepAlive.decode()
    end
  end
end
