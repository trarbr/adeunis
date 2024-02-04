defmodule Adeunis.Codec.PeriodicDataTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.PeriodicData
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %PeriodicData{
             period: 1,
             status: %Status{},
             registers: <<0x0183::16, 0x1000::16>>
           } = PeriodicData.decode(<<0x44, 0x00, 0x0183::16, 0x1000::16>>)
  end
end
