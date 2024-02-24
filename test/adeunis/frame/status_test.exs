defmodule Adeunis.Frame.StatusTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.Status

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

  property "codec is symmetric" do
    check all status <- FrameGenerator.status() do
      assert status ==
               status
               |> Status.encode()
               |> Status.decode()
    end
  end
end
