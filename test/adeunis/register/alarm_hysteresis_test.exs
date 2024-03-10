defmodule Adeunis.Register.AlarmHysteresisTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmHysteresis

  test "decode/1" do
    assert %AlarmHysteresis{hysteresis: 1234} = AlarmHysteresis.decode(<<0x04D2::16>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.alarm_hysteresis() do
      assert register ==
               register
               |> AlarmHysteresis.encode()
               |> AlarmHysteresis.decode()
    end
  end
end
