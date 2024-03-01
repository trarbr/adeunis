defmodule Adeunis.Frame.GetRegistersResponseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.GetRegistersResponse
  alias Adeunis.Frame.Status

  test "decode/1" do
    assert %GetRegistersResponse{
             status: %Status{},
             registers: <<0x1234::16, 0xFF, 0x00000000::32>>
           } = GetRegistersResponse.decode(<<0x31, 0x80, 0x1234::16, 0xFF, 0x00000000::32>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.get_register_response() do
      assert frame ==
               frame
               |> GetRegistersResponse.encode()
               |> GetRegistersResponse.decode()
    end
  end
end
