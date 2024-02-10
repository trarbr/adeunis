defmodule Adeunis.Frame.ReadModbusRegistersRequest do
  defstruct [:slave_address, :register_type, :first_register_address, :number_of_registers]

  def decode(<<
        0x05,
        slave_address,
        register_type,
        first_register_address::16,
        number_of_registers
      >>) do
    %__MODULE__{
      slave_address: slave_address,
      register_type: decode_register_type(register_type),
      first_register_address: first_register_address,
      number_of_registers: number_of_registers
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x05,
      frame.slave_address,
      encode_register_type(frame.register_type),
      frame.first_register_address::16,
      frame.number_of_registers
    >>
  end

  @register_type %{
    0x00 => :holding,
    0x01 => :input
  }

  defp decode_register_type(register_type)
  defp encode_register_type(register_type)

  for {value, register_type} <- @register_type do
    defp decode_register_type(unquote(value)), do: unquote(register_type)
    defp encode_register_type(unquote(register_type)), do: unquote(value)
  end
end
