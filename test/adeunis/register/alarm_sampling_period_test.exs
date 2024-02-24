defmodule Adeunis.Register.AlarmSamplingPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmSamplingPeriod

  test "decode/1 can decode any valid register" do
    assert %AlarmSamplingPeriod{period: 30} = AlarmSamplingPeriod.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.alarm_sampling_period() do
      assert register ==
               register
               |> AlarmSamplingPeriod.encode()
               |> AlarmSamplingPeriod.decode()
    end
  end
end
