defmodule Adeunis.Codec.LorawanOptionsTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec.LorawanOptions

  test "decode/1" do
    assert %LorawanOptions{
             adr_activation: :on,
             duty_cycle_status: :on,
             class: :a
           } = LorawanOptions.decode(<<0x05>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.lorawan_options() do
      %LorawanOptions{} = LorawanOptions.decode(frame)
    end
  end
end
