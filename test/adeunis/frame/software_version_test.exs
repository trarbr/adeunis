defmodule Adeunis.Frame.SoftwareVersionTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.SoftwareVersion
  alias Adeunis.Frame.Status

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

  property "codec is symmetric" do
    check all frame <- FrameGenerator.software_version() do
      assert frame ==
               frame
               |> SoftwareVersion.encode()
               |> SoftwareVersion.decode()
    end
  end
end
