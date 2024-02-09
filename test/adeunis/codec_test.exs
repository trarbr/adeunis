defmodule Adeunis.CodecTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.FrameGenerator
  alias Adeunis.Codec

  property "decode/1 can decode any valid frame" do
    check all frame <- FrameGenerator.frame() do
      assert %{} = Codec.decode(frame)
    end
  end

  property "codec is symmetric" do
    check all frame <- FrameGenerator.frame() do
      assert frame ==
               frame
               |> Codec.decode()
               |> Codec.encode()
    end
  end
end
