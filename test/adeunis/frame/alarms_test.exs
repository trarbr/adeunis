defmodule Adeunis.Frame.AlarmsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.Alarms
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %Alarms{
             status: %Status{},
             alarm_status: :high_threshold,
             slave_address: 160,
             register_address: 50,
             register_value: <<0x1234::16>>
           } = Alarms.decode(<<0x45, 0x00, 0x01, 0xA0, 0x0032::16, 0x1234::16>>)

    assert %Alarms{
             status: %Status{},
             alarm_status: :high_threshold,
             slave_address: 160,
             register_address: 50,
             register_value: <<0x12345678::32>>
           } = Alarms.decode(<<0x45, 0x00, 0x01, 0xA0, 0x0032::16, 0x12345678::32>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.alarms() do
      assert frame ==
               frame
               |> Alarms.encode()
               |> Alarms.decode()
    end
  end
end
