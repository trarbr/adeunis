defmodule Adeunis.Codec.NetworkConfigurationTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.NetworkConfiguration
  alias Adeunis.Codec.LorawanOptions
  alias Adeunis.Codec.Status

  test "decode/1" do
    assert %NetworkConfiguration{
             status: %Status{},
             lora_options: %LorawanOptions{},
             provisioning_mode: :otaa
           } =
             NetworkConfiguration.decode(<<
               0x20,
               0x20,
               0x25,
               0x01
             >>)
  end
end
