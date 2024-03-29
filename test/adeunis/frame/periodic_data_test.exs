defmodule Adeunis.Frame.PeriodicDataTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.PeriodicData
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %PeriodicData{
             period: 1,
             status: %Status{},
             registers: <<0x0183::16, 0x1000::16>>
           } = PeriodicData.decode(<<0x44, 0x00, 0x0183::16, 0x1000::16>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.periodic_data() do
      assert frame ==
               frame
               |> PeriodicData.encode()
               |> PeriodicData.decode()
    end
  end
end
