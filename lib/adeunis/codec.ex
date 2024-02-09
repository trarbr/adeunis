defmodule Adeunis.Codec do
  alias Adeunis.Codec

  @periodic_data_frame_codes Codec.PeriodicData.frame_codes()

  @frame_code_to_codec %{
    0x10 => Codec.ProductConfiguration,
    0x20 => Codec.NetworkConfiguration,
    0x2F => Codec.WriteModbusRegistersAck,
    0x30 => Codec.KeepAlive,
    0x31 => Codec.GetRegisterResponse,
    0x33 => Codec.SetRegisterResponse,
    0x37 => Codec.SoftwareVersion,
    0x45 => Codec.Alarms,
    0x5E => Codec.ReadModbusRegistersResponse
  }

  def decode(frame)

  def decode(<<frame_code, _rest::bytes>> = frame)
      when frame_code in @periodic_data_frame_codes do
    Codec.PeriodicData.decode(frame)
  end

  def encode(frame)

  def encode(%Codec.PeriodicData{} = frame) do
    Codec.PeriodicData.encode(frame)
  end

  for {frame_code, codec} <- @frame_code_to_codec do
    def decode(<<unquote(frame_code), _rest::bytes>> = frame), do: unquote(codec).decode(frame)
    def encode(%unquote(codec){} = frame), do: unquote(codec).encode(frame)
  end
end
