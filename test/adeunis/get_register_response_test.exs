defmodule Adeunis.GetRegisterResponseTest do
  use ExUnit.Case, async: true

  alias Adeunis.GetRegisterResponse

  test "decode/1" do
    %GetRegisterResponse{
      status: %Adeunis.Status{},
      registers: <<0x1234::16, 0xFF, 0x00000000::32>>
    } = GetRegisterResponse.decode(<<0x31, 0x80, 0x1234::16, 0xFF, 0x00000000::32>>)
  end
end
