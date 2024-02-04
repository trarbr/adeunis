defmodule Adeunis.Codec.Alarms do
  alias Adeunis.Codec

  defstruct [:status, :alarm_status, :slave_address, :register_address, :register_value]

  def decode(<<
        0x45,
        status::bytes-1,
        alarm_status,
        slave_address,
        register_address::16,
        register_value::bytes
      >>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      alarm_status: decode_alarm_status(alarm_status),
      slave_address: slave_address,
      register_address: register_address,
      register_value: decode_register_value(register_value)
    }
  end

  defp decode_alarm_status(alarm_status_byte) do
    case alarm_status_byte do
      0x00 -> :none
      0x01 -> :high_threshold
      0x02 -> :low_threshold
    end
  end

  defp decode_register_value(<<register_value::16>>) do
    register_value
  end

  defp decode_register_value(<<register_value::32>>) do
    register_value
  end
end
