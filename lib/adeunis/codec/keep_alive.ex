defmodule Adeunis.Codec.KeepAlive do
  alias Adeunis.Codec

  defstruct [:status]

  def decode(<<0x30, status::bytes-1>>) do
    %__MODULE__{
      status: Codec.Status.decode(status)
    }
  end
end
