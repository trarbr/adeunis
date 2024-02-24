defmodule Adeunis.Frame.ModbusLinkConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ModbusLinkConfiguration

  test "decode/1" do
    assert %ModbusLinkConfiguration{
             bus_type: :rs_485,
             stop_bits: 1,
             parity: :even,
             baud_rate: 19200
           } = ModbusLinkConfiguration.decode(<<0x44>>)
  end

  property "codec is symmetric" do
    check all modbus_config <- RegisterGenerator.modbus_link_configuration() do
      assert modbus_config ==
               modbus_config
               |> ModbusLinkConfiguration.encode()
               |> ModbusLinkConfiguration.decode()
    end
  end
end
