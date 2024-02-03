defmodule Adeunis.SoftwareVersionTest do
  use ExUnit.Case, async: true

  alias Adeunis.SoftwareVersion

  test "decode/1" do
    assert %SoftwareVersion{
             app_version: %{
               major: 2,
               minor: 1,
               patch: 0
             },
             rtu_version: %{
               major: 2,
               minor: 0,
               patch: 1
             }
           } = SoftwareVersion.decode(<<0x37, 0x20, 0x020100::24, 0x020001::24>>)
  end
end
