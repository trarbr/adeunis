defmodule Adeunis.Codec.ModbusConfigTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.ModbusConfig

  test "decode/1" do
    assert %ModbusConfig{
             bus_type: :rs_485,
             stop_bits: 1,
             parity: :even,
             baud_rate: 19200
           } = ModbusConfig.decode(<<0x44>>)
  end
end
