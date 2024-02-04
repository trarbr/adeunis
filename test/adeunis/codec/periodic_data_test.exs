defmodule Adeunis.Codec.PeriodicDataTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.PeriodicData
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %PeriodicData{
             period: 1,
             status: %Status{},
             registers: <<0x0183::16, 0x1000::16>>
           } = PeriodicData.decode(<<0x44, 0x00, 0x0183::16, 0x1000::16>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.periodic_data() do
      %PeriodicData{} = PeriodicData.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.periodic_data() do
      assert frame ==
               frame
               |> PeriodicData.decode()
               |> PeriodicData.encode()
    end
  end
end
