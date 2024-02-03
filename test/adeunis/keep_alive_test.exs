defmodule Adeunis.KeepAliveTest do
  use ExUnit.Case, async: true

  alias Adeunis.KeepAlive

  test "decode/1" do
    assert %KeepAlive{
             status: %Adeunis.Status{}
           } = KeepAlive.decode(<<0x30, 0x22>>)
  end
end
