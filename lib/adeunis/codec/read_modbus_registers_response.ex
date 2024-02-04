defmodule Adeunis.Codec.ReadModbusRegistersResponse do
  alias Adeunis.Codec

  defstruct [:status, :registers]

  def decode(<<0x5E, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      registers: registers
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x5E,
      Codec.Status.encode(frame.status)::bytes-1,
      frame.registers::bytes
    >>
  end
end
