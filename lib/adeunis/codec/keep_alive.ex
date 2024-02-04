defmodule Adeunis.Codec.KeepAlive do
  alias Adeunis.Codec

  defstruct [:status]

  def decode(<<0x30, status::bytes-1>>) do
    %__MODULE__{
      status: Codec.Status.decode(status)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x30,
      Codec.Status.encode(frame.status)::bytes-1
    >>
  end
end
