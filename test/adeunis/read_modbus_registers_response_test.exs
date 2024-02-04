defmodule Adeunis.ReadModbusRegistersResponseTest do
  use ExUnit.Case, async: true

  alias Adeunis.ReadModbusRegistersResponse

  test "decode/1" do
    %ReadModbusRegistersResponse{
      status: %Adeunis.Status{},
      registers: <<0x0183::16, 0x1000::16>>
    } = ReadModbusRegistersResponse.decode(<<0x5E, 0x00, 0x0183::16, 0x1000::16>>)
  end
end
