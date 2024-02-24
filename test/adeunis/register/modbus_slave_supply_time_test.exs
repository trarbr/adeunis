defmodule Adeunis.Register.ModbusSlaveSupplyTimeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ModbusSlaveSupplyTime

  test "decode/1 can decode any valid register" do
    assert %ModbusSlaveSupplyTime{supply_time: 25_000} =
             ModbusSlaveSupplyTime.decode(<<0x00, 0xFA>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.modbus_slave_supply_time() do
      assert frame ==
               frame
               |> ModbusSlaveSupplyTime.encode()
               |> ModbusSlaveSupplyTime.decode()
    end
  end
end