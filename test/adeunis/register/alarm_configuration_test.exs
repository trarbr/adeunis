defmodule Adeunis.Register.AlarmConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.AlarmConfiguration

  test "decode/1 can decode any valid register" do
    assert %AlarmConfiguration{
             slave_address: 120,
             first_register_address: 0xFA04,
             data_type: :int16,
             modbus_register_type: :holding,
             active_thresholds: :high_and_low
           } =
             AlarmConfiguration.decode(<<
               0x78,
               0xFA04::16,
               0::1,
               1::3,
               0::1,
               0::1,
               3::2
             >>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.alarm_configuration() do
      assert register ==
               register
               |> AlarmConfiguration.encode()
               |> AlarmConfiguration.decode()
    end
  end
end
