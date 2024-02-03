defmodule Adeunis.NetworkConfigurationTest do
  use ExUnit.Case, async: true

  alias Adeunis.NetworkConfiguration

  test "decode/1" do
    assert %NetworkConfiguration{
             status: %Adeunis.Status{},
             lora_options: %Adeunis.LorawanOptions{},
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
