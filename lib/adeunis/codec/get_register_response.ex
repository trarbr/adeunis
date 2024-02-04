defmodule Adeunis.Codec.GetRegisterResponse do
  alias Adeunis.Codec

  defstruct [:status, :registers]

  def decode(<<0x31, status::bytes-1, registers::bytes>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      registers: registers
    }
  end
end
