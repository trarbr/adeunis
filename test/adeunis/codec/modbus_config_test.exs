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
    check all frame <- FrameGenerator.modbus_config() do
      %ModbusConfig{} = ModbusConfig.decode(frame)
    end
  end
end
