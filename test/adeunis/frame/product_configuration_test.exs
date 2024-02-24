defmodule Adeunis.Frame.ProductConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.ProductConfiguration
  alias Adeunis.Register.ModbusLinkConfiguration
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %ProductConfiguration{
             status: %Status{},
             transmission_period_keep_alive: 8640,
             transmission_period_periodic_frame: 8640,
             sampling_period: 180,
             modbus_config: %ModbusLinkConfiguration{},
             modbus_slave_supply_time: 256
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
