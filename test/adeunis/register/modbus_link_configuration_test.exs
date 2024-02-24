defmodule Adeunis.Frame.ModbusLinkConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ModbusLinkConfiguration

  test "decode/1 can decode any valid register" do
    assert %ModbusLinkConfiguration{
             bus_type: :rs_485,
             stop_bits: 1,
             parity: :even,
             baud_rate: 19200
           } = ModbusLinkConfiguration.decode(<<0x44>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.modbus_link_configuration() do
      assert register ==
               register
               |> ModbusLinkConfiguration.encode()
               |> ModbusLinkConfiguration.decode()
    end
  end
end
