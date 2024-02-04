defmodule Adeunis.Codec.ReadModbusRegistersResponseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.ReadModbusRegistersResponse
  alias Adeunis.Codec.Status

  test "decode/1" do
    %ReadModbusRegistersResponse{
      status: %Status{},
      registers: <<0x0183::16, 0x1000::16>>
    } = ReadModbusRegistersResponse.decode(<<0x5E, 0x00, 0x0183::16, 0x1000::16>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.read_modbus_registers_response() do
      %ReadModbusRegistersResponse{} = ReadModbusRegistersResponse.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.read_modbus_registers_response() do
      assert frame ==
               frame
               |> ReadModbusRegistersResponse.decode()
               |> ReadModbusRegistersResponse.encode()
    end
  end
end
