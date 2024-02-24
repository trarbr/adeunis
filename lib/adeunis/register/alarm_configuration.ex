defmodule Adeunis.Register.AlarmConfiguration do
  defstruct [
    :slave_address,
    :first_register_address,
    :data_type,
    :modbus_register_type,
    :active_thresholds
  ]

  def decode(<<
        slave_address,
        first_register_address::16,
        _::1,
        data_type::3,
        _::1,
        modbus_register_type::1,
        active_thresholds::2
      >>) do
    %__MODULE__{
      slave_address: slave_address,
      first_register_address: first_register_address,
      data_type: decode_data_type(data_type),
      modbus_register_type: decode_register_type(modbus_register_type),
      active_thresholds: decode_active_thresholds(active_thresholds)
    }
  end

  def encode(%__MODULE__{} = register) do
    <<
      register.slave_address,
      register.first_register_address::16,
      0::1,
      encode_data_type(register.data_type)::3,
      0::1,
      encode_register_type(register.modbus_register_type)::1,
      encode_active_thresholds(register.active_thresholds)::2
    >>
  end

  @data_type %{
    0 => :uint16,
    1 => :int16,
    2 => :uint32,
    3 => :int32,
    4 => :uint32_word_swap,
    5 => :int32_word_swap
  }

  defp decode_data_type(data_type)
  defp encode_data_type(data_type)

  for {value, data_type} <- @data_type do
    defp decode_data_type(unquote(value)), do: unquote(data_type)
    defp encode_data_type(unquote(data_type)), do: unquote(value)
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

  @active_thresholds %{
    1 => :low,
    2 => :high,
    3 => :high_and_low
  }

  defp decode_active_thresholds(active_thresholds)
  defp encode_active_thresholds(active_thresholds)

  for {value, active_thresholds} <- @active_thresholds do
    defp decode_active_thresholds(unquote(value)), do: unquote(active_thresholds)
    defp encode_active_thresholds(unquote(active_thresholds)), do: unquote(value)
  end
end
