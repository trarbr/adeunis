defmodule Adeunis.StatusTest do
  use ExUnit.Case, async: true

  test "decode/1" do
    assert %Adeunis.Status{
             configuration_done: 1,
             low_battery: 0,
             hardware_error: 0,
             app_flag_1: 0,
             app_flag_2: 0,
             frame_counter: 5
           } = Adeunis.Status.decode(<<0b10100001>>)
  end
end
