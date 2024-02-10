defmodule Adeunis.Frame.RebootTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame.Reboot

  test "decode/1" do
    %Reboot{
      delay: 1440
    } = Reboot.decode(<<0x48, 0x05A0::16>>)
  end

  property "decode/1 decodes any valid frame" do
    check all frame <- FrameGenerator.reboot() do
      %Reboot{} = Reboot.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.reboot() do
      assert frame ==
               frame
               |> Reboot.decode()
               |> Reboot.encode()
    end
  end
end
