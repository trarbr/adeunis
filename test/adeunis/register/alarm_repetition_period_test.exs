defmodule Adeunis.Register.AlarmRepetitionPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmRepetitionPeriod

  test "decode/1" do
    assert %AlarmRepetitionPeriod{period: 35} = AlarmRepetitionPeriod.decode(<<0x00, 0x23>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.alarm_repetition_period() do
      assert register ==
               register
               |> AlarmRepetitionPeriod.encode()
               |> AlarmRepetitionPeriod.decode()
    end
  end
end
