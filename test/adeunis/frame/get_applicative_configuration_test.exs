defmodule Adeunis.Frame.GetApplicativeConfigurationTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.GetApplicativeConfiguration

  test "decode/1" do
    assert %GetApplicativeConfiguration{} = GetApplicativeConfiguration.decode(<<0x01>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.get_applicative_configuration() do
      %GetApplicativeConfiguration{} = GetApplicativeConfiguration.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.get_applicative_configuration() do
      assert frame ==
               frame
               |> GetApplicativeConfiguration.decode()
               |> GetApplicativeConfiguration.encode()
    end
  end
end
