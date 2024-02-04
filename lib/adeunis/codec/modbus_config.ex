defmodule Adeunis.Codec.ModbusConfig do
  defstruct [:bus_type, :stop_bits, :parity, :baud_rate]

  def decode(<<baud_rate::4, parity::2, stop_bits::1, bus_type::1>>) do
    %__MODULE__{
      bus_type: decode_bus_type(bus_type),
      stop_bits: stop_bits + 1,
      parity: decode_parity(parity),
      baud_rate: decode_baud_rate(baud_rate)
    }
  end

  def encode(%__MODULE__{} = modbus_config) do
    <<
      encode_baud_rate(modbus_config.baud_rate)::4,
      encode_parity(modbus_config.parity)::2,
      modbus_config.stop_bits - 1::1,
      encode_bus_type(modbus_config.bus_type)::1
    >>
  end

  @bus_type %{
    0 => :rs_485,
    1 => :rs_232
  }

  defp decode_bus_type(bus_type)
  defp encode_bus_type(bus_type)

  for {value, bus_type} <- @bus_type do
    defp decode_bus_type(unquote(value)), do: unquote(bus_type)
    defp encode_bus_type(unquote(bus_type)), do: unquote(value)
  end

  @parity %{
    0 => :none,
    1 => :even,
    2 => :odd
  }

  defp decode_parity(parity_bits)
  defp encode_parity(parity)

  for {value, parity} <- @parity do
    defp decode_parity(unquote(value)), do: unquote(parity)
    defp encode_parity(unquote(parity)), do: unquote(value)
  end

  @baud_rate %{
    0x00 => 1200,
    0x01 => 2400,
    0x02 => 4800,
    0x03 => 9600,
    0x04 => 19200,
    0x05 => 38400,
    0x06 => 57600,
    0x07 => 115_200
  }

  defp decode_baud_rate(baud_rate_bits)
  defp encode_baud_rate(baud_rate)

  for {value, baud_rate} <- @baud_rate do
    defp decode_baud_rate(unquote(value)), do: unquote(baud_rate)
    defp encode_baud_rate(unquote(baud_rate)), do: unquote(value)
  end
end
