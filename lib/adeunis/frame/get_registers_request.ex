defmodule Adeunis.Frame.GetRegistersRequest do
  defstruct [:registers]

  def decode(<<0x40, registers::bytes>>) do
    registers =
      for <<register <- registers>> do
        register + 300
      end

    %__MODULE__{
      registers: registers
    }
  end

  def encode(%__MODULE__{} = frame) do
    registers =
      for register <- frame.registers, into: <<>> do
        <<register - 300>>
      end

    <<0x40, registers::bytes>>
  end
end
