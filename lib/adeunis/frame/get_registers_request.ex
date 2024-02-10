defmodule Adeunis.Frame.GetRegistersRequest do
  defstruct [:first_register, :second_register, :third_register]

  def decode(<<
        0x40,
        first_register,
        second_register,
        third_register
      >>) do
    %__MODULE__{
      first_register: 300 + first_register,
      second_register: 300 + second_register,
      third_register: 300 + third_register
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<0x40, frame.first_register - 300, frame.second_register - 300, frame.third_register - 300>>
  end
end
