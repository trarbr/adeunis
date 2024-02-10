defmodule Adeunis.Frame.WriteModbusRegistersAck do
  alias Adeunis.Frame

  defstruct [:status, :downlink_framecode, :request_status]

  def decode(<<0x2F, status::bytes-1, downlink_framecode, request_status>>) do
    %__MODULE__{
      status: Frame.Status.decode(status),
      downlink_framecode: downlink_framecode,
      request_status: decode_request_status(request_status)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x2F,
      Frame.Status.encode(frame.status)::bytes-1,
      frame.downlink_framecode,
      encode_request_status(frame.request_status)
    >>
  end

  @request_status %{
    0x01 => :success,
    0x02 => {:error, :generic},
    0x03 => {:error, :invalid_request}
  }

  defp decode_request_status(request_status)
  defp encode_request_status(request_status)

  for {value, request_status} <- @request_status do
    defp decode_request_status(unquote(value)), do: unquote(request_status)
    defp encode_request_status(unquote(request_status)), do: unquote(value)
  end
end
