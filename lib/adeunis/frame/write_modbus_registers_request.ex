defmodule Adeunis.Frame.WriteModbusRegistersRequest do
  defstruct [:slave_address, :first_register_address, :number_of_registers, :register_values]

  def decode(<<
        0x08,
        slave_address,
        first_register_address::16,
        number_of_registers,
        register_values::bytes-unit(16)-size(number_of_registers)
      >>) do
    %__MODULE__{
      slave_address: slave_address,
      first_register_address: first_register_address,
      number_of_registers: number_of_registers,
      register_values: register_values
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x08,
      frame.slave_address,
      frame.first_register_address::16,
      frame.number_of_registers,
      frame.register_values::bytes
    >>
  end
end
