defmodule Adeunis.Register.AlarmThresholdTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmThreshold

  test "decode/1" do
    assert %AlarmThreshold{threshold: 305_419_896} = AlarmThreshold.decode(<<0x12345678::32>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.alarm_threshold() do
      assert register ==
               register
               |> AlarmThreshold.encode()
               |> AlarmThreshold.decode()
    end
  end
end
