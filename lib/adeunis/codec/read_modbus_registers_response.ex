defmodule Adeunis.Codec.ReadModbusRegistersResponse do
  alias Adeunis.Codec

  defstruct [:status, :registers]

  def decode(<<0x5E, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      registers: registers
    }
  end
end
