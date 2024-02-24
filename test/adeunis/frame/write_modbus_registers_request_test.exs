defmodule Adeunis.Frame.WriteModbusRegistersRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.WriteModbusRegistersRequest

  test "decode/1" do
    assert %WriteModbusRegistersRequest{
             slave_address: 10,
             first_register_address: 32,
             number_of_registers: 3,
             register_values: <<0x1234::16, 0x5678::16, 0x9ABC::16>>
           } =
             WriteModbusRegistersRequest.decode(<<
               0x08,
               0x0A,
               0x0020::16,
               0x03,
               0x1234::16,
               0x5678::16,
               0x9ABC::16
             >>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.write_modbus_registers_request() do
      assert frame ==
               frame
               |> WriteModbusRegistersRequest.encode()
               |> WriteModbusRegistersRequest.decode()
    end
  end
end
