defmodule Adeunis.PeriodicDataTest do
  use ExUnit.Case, async: true

  alias Adeunis.PeriodicData

  test "decode/1" do
    assert %PeriodicData{
             period: 1,
             status: %Adeunis.Status{},
             registers: <<0x0183::16, 0x1000::16>>
           } = PeriodicData.decode(<<0x44, 0x00, 0x0183::16, 0x1000::16>>)
  end
end
