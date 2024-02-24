defmodule Adeunis.Register.PeriodicTransmitPeriodTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.PeriodicTransmitPeriod

  test "decode/1 can decode any valid register" do
    assert %PeriodicTransmitPeriod{period: 30} = PeriodicTransmitPeriod.decode(<<0x00, 0x03>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.periodic_transmit_period() do
      assert frame ==
               frame
               |> PeriodicTransmitPeriod.encode()
               |> PeriodicTransmitPeriod.decode()
    end
  end
end
