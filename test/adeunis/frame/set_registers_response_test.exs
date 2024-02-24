defmodule Adeunis.Frame.SetRegistersResponseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.SetRegistersResponse
  alias Adeunis.Frame.Status

  test "decode/1" do
    %SetRegistersResponse{
      status: %Status{},
      request_status: {:error, :invalid_register},
      register_id: 0x0140
    } = SetRegistersResponse.decode(<<0x33, 0x80, 0x04, 0x0140::16>>)

    %SetRegistersResponse{
      status: %Status{},
      request_status: :success,
      register_id: nil
    } = SetRegistersResponse.decode(<<0x33, 0x80, 0x01>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.set_register_response() do
      assert frame ==
               frame
               |> SetRegistersResponse.encode()
               |> SetRegistersResponse.decode()
    end
  end
end
