defmodule Adeunis.Frame.NetworkConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.NetworkConfiguration
  alias Adeunis.Frame.Status
  alias Adeunis.Register

  test "decode/1" do
    assert %NetworkConfiguration{
             status: %Status{},
             lora_options: %Register.LorawanOptions{},
             provisioning_mode: :otaa
           } =
             NetworkConfiguration.decode(<<
               0x20,
               0x20,
               0x25,
               0x01
             >>)
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.network_configuration() do
      assert frame ==
               frame
               |> NetworkConfiguration.encode()
               |> NetworkConfiguration.decode()
    end
  end
end
