defmodule Adeunis.Frame.ReadModbusRegistersResponseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.ReadModbusRegistersResponse
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %ReadModbusRegistersResponse{
             status: %Status{},
             registers: <<0x0183::16, 0x1000::16>>
           } = ReadModbusRegistersResponse.decode(<<0x5E, 0x00, 0x0183::16, 0x1000::16>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.read_modbus_registers_response() do
      assert frame ==
               frame
               |> ReadModbusRegistersResponse.encode()
               |> ReadModbusRegistersResponse.decode()
    end
  end
end
