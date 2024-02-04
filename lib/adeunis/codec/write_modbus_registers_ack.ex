defmodule Adeunis.Codec.WriteModbusRegistersAck do
  alias Adeunis.Codec

  defstruct [:status, :downlink_framecode, :request_status]

  def decode(<<0x2F, status::bytes-1, downlink_framecode, request_status>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      downlink_framecode: downlink_framecode,
      request_status: decode_request_status(request_status)
    }
  end

  def decode_request_status(request_status) do
    case request_status do
      0x01 -> :success
      0x02 -> {:error, :generic}
      0x03 -> {:error, :invalid_request}
    end
  end
end
