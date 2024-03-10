defmodule Adeunis.Register.ProductModeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ProductMode

  test "decode/1" do
    assert %ProductMode{mode: :park} = ProductMode.decode(<<0>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.product_mode() do
      assert register ==
               register
               |> ProductMode.encode()
               |> ProductMode.decode()
    end
  end
end
