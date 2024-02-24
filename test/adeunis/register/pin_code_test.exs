defmodule Adeunis.Register.PINCodeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.PINCode

  test "decode/1 can decode any valid register" do
    assert %PINCode{code: 7373} = PINCode.decode(<<0x1CCD::16>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.pin_code() do
      assert frame ==
               frame
               |> PINCode.encode()
               |> PINCode.decode()
    end
  end
end
