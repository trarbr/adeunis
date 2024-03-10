defmodule Adeunis.Register.ModbusSlaveSupplyTimeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ModbusSlaveSupplyTime

  test "decode/1" do
    assert %ModbusSlaveSupplyTime{supply_time: 25_000} =
             ModbusSlaveSupplyTime.decode(<<0x00, 0xFA>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.modbus_slave_supply_time() do
      assert register ==
               register
               |> ModbusSlaveSupplyTime.encode()
               |> ModbusSlaveSupplyTime.decode()
    end
  end
end
