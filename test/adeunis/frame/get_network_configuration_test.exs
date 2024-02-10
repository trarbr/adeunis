defmodule Adeunis.Frame.GetNetworkConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.GetNetworkConfiguration

  test "decode/1" do
    assert %GetNetworkConfiguration{} = GetNetworkConfiguration.decode(<<0x02>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.get_network_configuration() do
      %GetNetworkConfiguration{} = GetNetworkConfiguration.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.get_network_configuration() do
      assert frame ==
               frame
               |> GetNetworkConfiguration.decode()
               |> GetNetworkConfiguration.encode()
    end
  end
end
