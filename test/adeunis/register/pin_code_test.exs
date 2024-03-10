defmodule Adeunis.Register.PINCodeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.PINCode

  test "decode/1" do
    assert %PINCode{code: 7373} = PINCode.decode(<<0x1CCD::16>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.pin_code() do
      assert register ==
               register
               |> PINCode.encode()
               |> PINCode.decode()
    end
  end
end
