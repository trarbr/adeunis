defmodule Adeunis.ReadModbusRegistersResponse do
  defstruct [:status, :registers]

  def decode(<<0x5E, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Adeunis.Status.decode(status),
      registers: registers
    }
  end
end
