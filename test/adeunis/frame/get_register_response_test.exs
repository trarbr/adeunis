defmodule Adeunis.Frame.GetRegisterResponseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.GetRegisterResponse
  alias Adeunis.Frame.Status

  test "decode/1" do
    %GetRegisterResponse{
      status: %Status{},
      registers: <<0x1234::16, 0xFF, 0x00000000::32>>
    } = GetRegisterResponse.decode(<<0x31, 0x80, 0x1234::16, 0xFF, 0x00000000::32>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.get_register_response() do
      %GetRegisterResponse{} = GetRegisterResponse.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.get_register_response() do
      assert frame ==
               frame
               |> GetRegisterResponse.decode()
               |> GetRegisterResponse.encode()
    end
  end
end
