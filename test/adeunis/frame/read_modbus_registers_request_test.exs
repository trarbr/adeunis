defmodule Adeunis.Frame.ReadModbusRegistersRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.ReadModbusRegistersRequest

  test "decode/1" do
    %ReadModbusRegistersRequest{
      slave_address: 10,
      register_type: :input,
      first_register_address: 32,
      number_of_registers: 2
    } = ReadModbusRegistersRequest.decode(<<0x05, 0x0A, 0x01, 0x0020::16, 0x02>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.read_modbus_registers_request() do
      assert frame ==
               frame
               |> ReadModbusRegistersRequest.encode()
               |> ReadModbusRegistersRequest.decode()
    end
  end
end
