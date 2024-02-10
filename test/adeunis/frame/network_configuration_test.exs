defmodule Adeunis.Frame.NetworkConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.NetworkConfiguration
  alias Adeunis.Frame.LorawanOptions
  alias Adeunis.Frame.Status

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

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.network_configuration() do
      %NetworkConfiguration{} = NetworkConfiguration.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.network_configuration() do
      assert frame ==
               frame
               |> NetworkConfiguration.decode()
               |> NetworkConfiguration.encode()
    end
  end
end
