defmodule Adeunis.Frame.ModbusConfigTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.ModbusConfig

  test "decode/1" do
    assert %ModbusConfig{
             bus_type: :rs_485,
             stop_bits: 1,
             parity: :even,
             baud_rate: 19200
           } = ModbusConfig.decode(<<0x44>>)
  end

  property "codec is symmetric" do
    check all modbus_config <- FrameGenerator.modbus_config() do
      assert modbus_config ==
               modbus_config
               |> ModbusConfig.encode()
               |> ModbusConfig.decode()
    end
  end
end
