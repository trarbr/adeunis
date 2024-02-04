defmodule Adeunis.Codec.LorawanOptions do
  defstruct [:adr_activation, :duty_cycle_status, :class]

  def decode(<<_::2, class::1, _::2, duty_cycle_status::1, _::1, adr_activation::1>>) do
    %__MODULE__{
      adr_activation: decode_adr_activation(adr_activation),
      duty_cycle_status: decode_duty_cycle_status(duty_cycle_status),
      class: decode_class(class)
    }
  end

  def encode(%__MODULE__{} = lorawan_options) do
    <<
      0::2,
      encode_class(lorawan_options.class)::1,
      0::2,
      encode_duty_cycle_status(lorawan_options.duty_cycle_status)::1,
      0::1,
      encode_adr_activation(lorawan_options.adr_activation)::1
    >>
  end

  @adr_activation %{
    0 => :off,
    1 => :on
  }

  defp decode_adr_activation(adr_activation)
  defp encode_adr_activation(adr_activation)

  for {value, adr_activation} <- @adr_activation do
    defp decode_adr_activation(unquote(value)), do: unquote(adr_activation)
    defp encode_adr_activation(unquote(adr_activation)), do: unquote(value)
  end

  @duty_cycle_status %{
    0 => :off,
    1 => :on
  }

  defp decode_duty_cycle_status(duty_cycle_status)
  defp encode_duty_cycle_status(duty_cycle_status)

  for {value, duty_cycle_status} <- @duty_cycle_status do
    defp decode_duty_cycle_status(unquote(value)), do: unquote(duty_cycle_status)
    defp encode_duty_cycle_status(unquote(duty_cycle_status)), do: unquote(value)
  end

  @class %{
    0 => :a,
    1 => :c
  }

  defp decode_class(class)
  defp encode_class(class)

  for {value, class} <- @class do
    defp decode_class(unquote(value)), do: unquote(class)
    defp encode_class(unquote(class)), do: unquote(value)
  end
end
