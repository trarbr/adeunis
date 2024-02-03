defmodule Adeunis.ModbusConfig do
  defstruct [:bus_type, :stop_bits, :parity, :baud_rate]

  def decode(<<baud_rate::4, parity::2, stop_bits::1, bus_type::1>>) do
    %__MODULE__{
      bus_type: bus_type(bus_type),
      stop_bits: stop_bits + 1,
      parity: parity(parity),
      baud_rate: baud_rate(baud_rate)
    }
  end

  defp bus_type(bus_type_bit) do
    case bus_type_bit do
      0 -> :rs_485
      1 -> :rs_232
    end
  end

  defp parity(parity_bits) do
    case parity_bits do
      0 -> :none
      1 -> :even
      2 -> :odd
    end
  end

  @baud_rate [
    1200,
    2400,
    4800,
    9600,
    19200,
    38400,
    57600,
    115_200
  ]

  defp baud_rate(baud_rate_bits)

  for {baud_rate, baud_rate_bits} <- Enum.with_index(@baud_rate) do
    defp baud_rate(unquote(baud_rate_bits)) do
      unquote(baud_rate)
    end
  end
end
