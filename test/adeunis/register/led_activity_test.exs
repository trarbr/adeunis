defmodule Adeunis.Register.LEDActivityTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.LEDActivity

  test "decode/1 can decode any valid register" do
    assert %LEDActivity{led_activity: :default} = LEDActivity.decode(<<0x18007F::32>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.led_activity() do
      assert frame ==
               frame
               |> LEDActivity.encode()
               |> LEDActivity.decode()
    end
  end
end
