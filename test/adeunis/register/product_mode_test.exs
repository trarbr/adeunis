defmodule Adeunis.Register.ProductModeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ProductMode

  test "decode/1 can decode any valid register" do
    assert %ProductMode{product_mode: :park} = ProductMode.decode(<<0>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.product_mode() do
      assert frame ==
               frame
               |> ProductMode.encode()
               |> ProductMode.decode()
    end
  end
end
