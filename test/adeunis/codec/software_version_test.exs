defmodule Adeunis.Codec.SoftwareVersionTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.SoftwareVersion
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %SoftwareVersion{
             status: %Status{},
             app_version: %Version{
               major: 2,
               minor: 1,
               patch: 0
             },
             rtu_version: %Version{
               major: 2,
               minor: 0,
               patch: 1
             }
           } = SoftwareVersion.decode(<<0x37, 0x20, 0x020100::24, 0x020001::24>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.software_version() do
      %SoftwareVersion{} = SoftwareVersion.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.software_version() do
      assert frame ==
               frame
               |> SoftwareVersion.decode()
               |> SoftwareVersion.encode()
    end
  end
end
