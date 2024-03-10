defmodule Adeunis.Register.PeriodicData do
  defstruct [
    :slave_address,
    :first_register_address,
    :associated_periodic_frame,
    :modbus_register_type,
    :number_of_registers
  ]

  def decode(<<
        slave_address,
        first_register_address::16,
        associated_periodic_frame::3,
        modbus_register_type::1,
        number_of_registers::4
      >>) do
    %__MODULE__{
      slave_address: slave_address,
      first_register_address: first_register_address,
      associated_periodic_frame: decode_associated_periodic_frame(associated_periodic_frame),
      modbus_register_type: decode_register_type(modbus_register_type),
      number_of_registers: number_of_registers
    }
  end

  def encode(%__MODULE__{} = register) do
    <<
      register.slave_address,
      register.first_register_address::16,
      encode_associated_periodic_frame(register.associated_periodic_frame)::3,
      encode_register_type(register.modbus_register_type)::1,
      register.number_of_registers::4
    >>
  end

  defp decode_associated_periodic_frame(associated_periodic_frame)
       when associated_periodic_frame in 0..5 do
    associated_periodic_frame + 1
  end

  defp encode_associated_periodic_frame(associated_periodic_frame)
       when associated_periodic_frame in 1..6 do
    associated_periodic_frame - 1
  end

  @register_type %{
    0 => :holding,
    1 => :input
  }

  defp decode_register_type(register_type)
  defp encode_register_type(register_type)

  for {value, register_type} <- @register_type do
    defp decode_register_type(unquote(value)), do: unquote(register_type)
    defp encode_register_type(unquote(register_type)), do: unquote(value)
  end
end
