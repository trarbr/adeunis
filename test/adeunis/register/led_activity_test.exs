defmodule Adeunis.Register.LEDActivityTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.LEDActivity

  test "decode/1" do
    assert %LEDActivity{led_activity: :default} = LEDActivity.decode(<<0x18007F::32>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.led_activity() do
      assert register ==
               register
               |> LEDActivity.encode()
               |> LEDActivity.decode()
    end
  end
end
