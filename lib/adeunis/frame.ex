defmodule Adeunis.Frame do
  alias Adeunis.Frame

  @periodic_data_frame_codes Frame.PeriodicData.frame_codes()

  @frame_code_to_module %{
    0x01 => Frame.GetApplicativeConfiguration,
    0x02 => Frame.GetNetworkConfiguration,
    0x05 => Frame.ReadModbusRegistersRequest,
    0x08 => Frame.WriteModbusRegistersRequest,
    0x10 => Frame.ProductConfiguration,
    0x20 => Frame.NetworkConfiguration,
    0x2F => Frame.WriteModbusRegistersAck,
    0x30 => Frame.KeepAlive,
    0x31 => Frame.GetRegisterResponse,
    0x33 => Frame.SetRegisterResponse,
    0x37 => Frame.SoftwareVersion,
    0x45 => Frame.Alarms,
    0x5E => Frame.ReadModbusRegistersResponse
  }

  def decode(frame)

  def decode(<<frame_code, _rest::bytes>> = frame)
      when frame_code in @periodic_data_frame_codes do
    Frame.PeriodicData.decode(frame)
  end

  def encode(frame)

  def encode(%Frame.PeriodicData{} = frame) do
    Frame.PeriodicData.encode(frame)
  end

  for {frame_code, module} <- @frame_code_to_module do
    def decode(<<unquote(frame_code), _rest::bytes>> = frame), do: unquote(module).decode(frame)
    def encode(%unquote(module){} = frame), do: unquote(module).encode(frame)
  end
end
