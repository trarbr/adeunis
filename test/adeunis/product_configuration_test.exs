defmodule Adeunis.ProductConfigurationTest do
  use ExUnit.Case, async: true

  alias Adeunis.ProductConfiguration

  test "decode/1" do
    assert %ProductConfiguration{
             status: %Adeunis.Status{},
             transmission_period_keep_alive: 8640,
             transmission_period_periodic_frame: 8640,
             sampling_period: 180,
             modbus_config: %Adeunis.ModbusConfig{},
             modbus_slave_supply_time: 256
           } =
             ProductConfiguration.decode(
               <<0x10, 0x10, 0x21C0::16, 0x21C0::16, 0x00B4::16, 0x44, 0x100::16>>
             )
  end
end
