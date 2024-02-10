defmodule Adeunis.Frame.Alarms do
  alias Adeunis.Frame

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
      status: Frame.Status.decode(status),
      alarm_status: decode_alarm_status(alarm_status),
      slave_address: slave_address,
      register_address: register_address,
      register_value: register_value
    }
  end

  def encode(%__MODULE__{} = alarms) do
    <<
      0x45,
      Frame.Status.encode(alarms.status)::bytes-1,
      encode_alarm_status(alarms.alarm_status),
      alarms.slave_address,
      alarms.register_address::16,
      alarms.register_value::bytes
    >>
  end

  @alarm_statuses %{
    0x00 => :none,
    0x01 => :high_threshold,
    0x02 => :low_threshold
  }

  defp decode_alarm_status(status)
  defp encode_alarm_status(status)

  for {value, status} <- @alarm_statuses do
    defp decode_alarm_status(unquote(value)), do: unquote(status)
    defp encode_alarm_status(unquote(status)), do: unquote(value)
  end
end
