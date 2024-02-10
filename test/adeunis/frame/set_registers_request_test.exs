defmodule Adeunis.Frame.SetRegistersRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.SetRegistersRequest

  test "decode/1" do
    %SetRegistersRequest{
      registers: <<0x14, 0x00AA::16, 0x1D, 0x02>>
    } = SetRegistersRequest.decode(<<0x41, 0x14, 0x00AA::16, 0x1D, 0x02>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.set_register_request() do
      %SetRegistersRequest{} = SetRegistersRequest.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.set_register_request() do
      assert frame ==
               frame
               |> SetRegistersRequest.decode()
               |> SetRegistersRequest.encode()
    end
  end
end
