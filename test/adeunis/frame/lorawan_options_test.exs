defmodule Adeunis.Frame.LorawanOptionsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.LorawanOptions

  test "decode/1" do
    assert %LorawanOptions{
             adr_activation: :on,
             duty_cycle_status: :on,
             class: :a
           } = LorawanOptions.decode(<<0x05>>)
  end

  property "codec is symmetric" do
    check all lorawan_options <- FrameGenerator.lorawan_options() do
      assert lorawan_options ==
               lorawan_options
               |> LorawanOptions.encode()
               |> LorawanOptions.decode()
    end
  end
end
