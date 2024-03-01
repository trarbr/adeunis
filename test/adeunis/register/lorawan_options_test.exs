defmodule Adeunis.Register.LorawanOptionsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.LorawanOptions

  test "decode/1" do
    assert %LorawanOptions{
             adr_activation: :on,
             duty_cycle_status: :on,
             class: :a
           } = LorawanOptions.decode(<<0x05>>)
  end

  property "codec is symmetric" do
    check all {_, lorawan_options} <- RegisterGenerator.lorawan_options() do
      assert lorawan_options ==
               lorawan_options
               |> LorawanOptions.encode()
               |> LorawanOptions.decode()
    end
  end
end
