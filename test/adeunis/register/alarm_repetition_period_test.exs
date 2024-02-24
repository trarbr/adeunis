defmodule Adeunis.Register.AlarmRepetitionPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmRepetitionPeriod

  test "decode/1 can decode any valid register" do
    assert %AlarmRepetitionPeriod{period: 35} = AlarmRepetitionPeriod.decode(<<0x00, 0x23>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.alarm_repetition_period() do
      assert frame ==
               frame
               |> AlarmRepetitionPeriod.encode()
               |> AlarmRepetitionPeriod.decode()
    end
  end
end
