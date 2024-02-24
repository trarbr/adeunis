defmodule Adeunis.Frame.WriteModbusRegistersAckTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.WriteModbusRegistersAck
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %WriteModbusRegistersAck{
             status: %Status{},
             downlink_framecode: 0x08,
             request_status: :success
           } = WriteModbusRegistersAck.decode(<<0x2F, 0x20, 0x08, 0x01>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.write_modbus_registers_ack() do
      assert frame ==
               frame
               |> WriteModbusRegistersAck.encode()
               |> WriteModbusRegistersAck.decode()
    end
  end
end
