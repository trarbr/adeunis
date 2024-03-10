defmodule Adeunis.Frame.PeriodicData do
  alias Adeunis.Frame

  defstruct [:period, :status, :registers]

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
