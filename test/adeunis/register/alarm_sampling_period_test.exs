defmodule Adeunis.Register.AlarmSamplingPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmSamplingPeriod

  test "decode/1 can decode any valid register" do
    assert %AlarmSamplingPeriod{period: 30} = AlarmSamplingPeriod.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.alarm_sampling_period() do
      assert frame ==
               frame
               |> AlarmSamplingPeriod.encode()
               |> AlarmSamplingPeriod.decode()
    end
  end
end
