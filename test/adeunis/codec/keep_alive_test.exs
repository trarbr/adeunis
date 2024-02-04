defmodule Adeunis.Codec.KeepAliveTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.KeepAlive
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %KeepAlive{
             status: %Status{}
           } = KeepAlive.decode(<<0x30, 0x22>>)
  end
end
