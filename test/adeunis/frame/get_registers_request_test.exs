defmodule Adeunis.Frame.GetRegistersRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.GetRegistersRequest

  test "decode/1" do
    %GetRegistersRequest{
      first_register: 300,
      second_register: 320,
      third_register: 332
    } = GetRegistersRequest.decode(<<0x40, 0x00, 0x14, 0x20>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.get_register_request() do
      assert frame ==
               frame
               |> GetRegistersRequest.encode()
               |> GetRegistersRequest.decode()
    end
  end
end
