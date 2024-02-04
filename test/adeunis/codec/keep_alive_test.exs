defmodule Adeunis.Codec.KeepAliveTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.KeepAlive
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %KeepAlive{
             status: %Status{}
           } = KeepAlive.decode(<<0x30, 0x22>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.keep_alive() do
      %KeepAlive{} = KeepAlive.decode(frame)
    end
  end
end
