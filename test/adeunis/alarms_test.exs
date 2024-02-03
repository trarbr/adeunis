defmodule Adeunis.AlarmsTest do
  use ExUnit.Case, async: true

  alias Adeunis.Alarms

  test "decode/1" do
    assert %Alarms{
             status: %Adeunis.Status{},
             alarm_status: :high_threshold,
             slave_address: 160,
             register_address: 50,
             register_value: 4660
           } = Alarms.decode(<<0x45, 0x00, 0x01, 0xA0, 0x0032::16, 0x1234::16>>)

    assert %Alarms{
             status: %Adeunis.Status{},
             alarm_status: :high_threshold,
             slave_address: 160,
             register_address: 50,
             register_value: 305_419_896
           } = Alarms.decode(<<0x45, 0x00, 0x01, 0xA0, 0x0032::16, 0x12345678::32>>)
  end
end
