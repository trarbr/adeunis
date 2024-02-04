defmodule Adeunis.WriteModbusRegistersAckTest do
  use ExUnit.Case, async: true

  alias Adeunis.WriteModbusRegistersAck

  test "decode/1" do
    assert %WriteModbusRegistersAck{
             status: %Adeunis.Status{},
             downlink_framecode: 0x08,
             request_status: :success
           } = WriteModbusRegistersAck.decode(<<0x2F, 0x20, 0x08, 0x01>>)
  end
end
