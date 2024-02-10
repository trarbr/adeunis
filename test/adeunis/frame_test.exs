defmodule Adeunis.FrameTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame

  property "decode/1 can decode any valid frame" do
    check all frame <- FrameGenerator.frame() do
      assert %{} = Frame.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.frame() do
      assert frame ==
               frame
               |> Frame.decode()
               |> Frame.encode()
    end
  end
end
