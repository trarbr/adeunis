defmodule Adeunis.Frame.KeepAlive do
  alias Adeunis.Frame

  defstruct [:status]

  def decode(<<0x30, status::bytes-1>>) do
    %__MODULE__{
      status: Frame.Status.decode(status)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x30,
      Frame.Status.encode(frame.status)::bytes-1
    >>
  end
end
