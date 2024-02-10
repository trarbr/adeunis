defmodule Adeunis.Frame.PeriodicData do
  alias Adeunis.Frame

  defstruct [:period, :status, :registers]

  # Decode a periodic data frame
  # you need to know which bytes represent which data from somewhere else
  # without having that context, the only thing you can return is really an array of integers
  # and would that even make sense if you don't know the register type? I am not sure
  # Yes! Register types can be either
  # 0: holding registers (read/write), or
  # Holding registers are the most universal 16-bit register, may be read or written, and may be used for a variety of things including inputs, outputs, configuration data, or any requirement for "holding" data.
  # Modbus protocol defines a holding register as 16 bits wide; however, there is a widely used de facto standard for reading and writing data wider than 16 bits. The most common are IEEE 754 floating point, and 32-bit integer. The convention may also be extended to double precision floating point and 64-bit integer data.
  # The wide data simply consists of two consecutive "registers" treated as a single wide register. Floating point in 32-bit IEEE 754 standard, and 32-bit integer data, are widely used. Although the convention of register pairs is widely recognized, agreement on whether the high order or low order register should come first is not standardized.
  # 1: input registers (read only)
  # Input registers are 16-bit registers used for input, and may only be read
  def decode(<<frame_code, status::bytes-1, rest::bytes>>) do
    %__MODULE__{
      period: period_from_frame_code(frame_code),
      status: Frame.Status.decode(status),
      registers: rest
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      frame_code_from_period(frame.period),
      Frame.Status.encode(frame.status)::bytes-1,
      frame.registers::bytes
    >>
  end

  @frame_codes [
    0x44,
    0x5F,
    0x60,
    0x61,
    0x62,
    0x63
  ]

  @doc false
  def frame_codes() do
    @frame_codes
  end

  defp period_from_frame_code(frame_code)
  defp frame_code_from_period(frame_code)

  for {frame_code, period} <- Enum.with_index(@frame_codes, 1) do
    defp period_from_frame_code(unquote(frame_code)), do: unquote(period)
    defp frame_code_from_period(unquote(period)), do: unquote(frame_code)
  end
end
