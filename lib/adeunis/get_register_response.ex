defmodule Adeunis.GetRegisterResponse do
  defstruct [:status, :registers]

  def decode(<<0x31, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Adeunis.Status.decode(status),
      registers: registers
    }
  end
end
