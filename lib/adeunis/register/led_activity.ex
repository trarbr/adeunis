defmodule Adeunis.Register.LEDActivity do
  defstruct [:led_activity]

  def decode(<<led_activity::32>>) do
    %__MODULE__{led_activity: decode_led_activity(led_activity)}
  end

  def encode(%__MODULE__{} = register) do
    <<encode_led_activity(register.led_activity)::32>>
  end

  @led_activity %{
    0x18007F => :default,
    0x180070 => :eco
  }

  defp decode_led_activity(led_activity)
  defp encode_led_activity(led_activity)

  for {value, led_activity} <- @led_activity do
    defp decode_led_activity(unquote(value)), do: unquote(led_activity)
    defp encode_led_activity(unquote(led_activity)), do: unquote(value)
  end
end
