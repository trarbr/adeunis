defmodule Adeunis.Codec.ModbusConfigTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.ModbusConfig

  test "decode/1" do
    assert %ModbusConfig{
             bus_type: :rs_485,
             stop_bits: 1,
             parity: :even,
             baud_rate: 19200
           } = ModbusConfig.decode(<<0x44>>)
  end

  property "decode/1 decodes any valid frame" do
    check all modbus_config <- FrameGenerator.modbus_config() do
      %ModbusConfig{} = ModbusConfig.decode(modbus_config)
    end
  end

  property "codec is symmetric" do
    check all modbus_config <- FrameGenerator.modbus_config() do
      assert modbus_config ==
               modbus_config
               |> ModbusConfig.decode()
               |> ModbusConfig.encode()
    end
  end
end
