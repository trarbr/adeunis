defmodule Adeunis.Frame.SetRegistersRequest do
  defstruct [:registers]

  def decode(<<0x41, registers::bytes>>) do
    %__MODULE__{
      registers: registers
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<0x41, frame.registers::bytes>>
  end
end
