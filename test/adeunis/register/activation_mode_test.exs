defmodule Adeunis.Register.ActivationModeTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.ActivationMode

  test "decode/1" do
    assert %ActivationMode{
             mode: :abp
           } = ActivationMode.decode(<<0x00>>)
  end

  property "codec is symmetric" do
    check all {_, register} <- RegisterGenerator.activation_mode() do
      assert register ==
               register
               |> ActivationMode.encode()
               |> ActivationMode.decode()
    end
  end
end
