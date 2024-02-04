defmodule Adeunis.Codec.WriteModbusRegistersAckTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.WriteModbusRegistersAck
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %WriteModbusRegistersAck{
             status: %Status{},
             downlink_framecode: 0x08,
             request_status: :success
           } = WriteModbusRegistersAck.decode(<<0x2F, 0x20, 0x08, 0x01>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.write_modbus_registers_ack() do
      %WriteModbusRegistersAck{} = WriteModbusRegistersAck.decode(frame)
    end
  end
end
