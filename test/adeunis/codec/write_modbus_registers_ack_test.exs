defmodule Adeunis.Codec.WriteModbusRegistersAckTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.WriteModbusRegistersAck
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %WriteModbusRegistersAck{
             status: %Status{},
             downlink_framecode: 0x08,
             request_status: :success
           } = WriteModbusRegistersAck.decode(<<0x2F, 0x20, 0x08, 0x01>>)
  end
end
