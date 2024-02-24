defmodule Adeunis.FrameTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Frame

  property "codec is symmetric" do
    check all frame <- FrameGenerator.frame() do
      assert frame ==
               frame
               |> Frame.encode()
               |> Frame.decode()
    end
  end
end
