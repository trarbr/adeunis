defmodule Adeunis.Codec.StatusTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %Status{
             configuration_done: 1,
             low_battery: 0,
             hardware_error: 0,
             app_flag_1: 0,
             app_flag_2: 0,
             frame_counter: 5
           } = Status.decode(<<0b10100001>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.status() do
      %Status{} = Status.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all status <- FrameGenerator.status() do
      assert status ==
               status
               |> Status.decode()
               |> Status.encode()
    end
  end
end
