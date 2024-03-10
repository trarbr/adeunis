defmodule Adeunis.Frame.SetRegistersRequestTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.SetRegistersRequest

  test "decode/1" do
    assert %SetRegistersRequest{
             registers: [
               {320, %Adeunis.Register.AlarmSamplingPeriod{period: 1700}},
               {306, %Adeunis.Register.ProductMode{mode: :production}}
             ]
           } = SetRegistersRequest.decode(<<0x41, 0x14, 0x00AA::16, 0x06, 0x01>>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.set_register_request() do
      assert frame ==
               frame
               |> SetRegistersRequest.encode()
               |> SetRegistersRequest.decode()
    end
  end
end
