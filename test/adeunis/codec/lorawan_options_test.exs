defmodule Adeunis.Codec.LorawanOptionsTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.LorawanOptions

  test "decode/1" do
    assert %LorawanOptions{
             adr_activation: :on,
             duty_cycle_status: :on,
             class: :a
           } = LorawanOptions.decode(<<0x05>>)
  end
end
