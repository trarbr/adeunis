defmodule Adeunis.Frame.ProductConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.ProductConfiguration
  alias Adeunis.Frame.Status
  alias Adeunis.Register

  test "decode/1" do
    assert %ProductConfiguration{
             status: %Status{},
             keep_alive: %Register.KeepAlive{period: 86400},
             periodic_transmit_period: %Register.PeriodicTransmitPeriod{period: 86400},
             alarm_sampling_period: %Register.AlarmSamplingPeriod{period: 1800},
             modbus_link_configuration: %Register.ModbusLinkConfiguration{},
             modbus_slave_supply_time: %Register.ModbusSlaveSupplyTime{supply_time: 25600}
           } =
             ProductConfiguration.decode(
               <<0x10, 0x10, 0x21C0::16, 0x21C0::16, 0x00B4::16, 0x44, 0x100::16>>
             )
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.product_configuration() do
      assert frame ==
               frame
               |> ProductConfiguration.encode()
               |> ProductConfiguration.decode()
    end
  end
end
