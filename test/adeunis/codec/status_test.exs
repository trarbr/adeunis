defmodule Adeunis.Codec.StatusTest do
  use ExUnit.Case, async: true

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
end
