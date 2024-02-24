defmodule Adeunis.Register.PeriodicTransmitPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.PeriodicTransmitPeriod

  test "decode/1 can decode any valid register" do
    assert %PeriodicTransmitPeriod{period: 30} = PeriodicTransmitPeriod.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.periodic_transmit_period() do
      assert register ==
               register
               |> PeriodicTransmitPeriod.encode()
               |> PeriodicTransmitPeriod.decode()
    end
  end
end
