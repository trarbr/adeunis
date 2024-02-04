defmodule Adeunis.Codec.GetRegisterResponse do
  alias Adeunis.Codec

  defstruct [:status, :registers]

  def decode(<<0x31, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      registers: registers
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x31,
      Codec.Status.encode(frame.status)::bytes-1,
      frame.registers::bytes
    >>
  end
end
