defmodule Adeunis.Codec.SetRegisterResponse do
  alias Adeunis.Codec

  defstruct [:status, :request_status, :register_id]

  def decode(<<0x33, status::bytes-1, response::bytes>>) do
    {request_status, register_id} = unpack_response(response)

    %__MODULE__{
      status: Codec.Status.decode(status),
      request_status: decode_request_status(request_status),
      register_id: register_id
    }
  end

  def unpack_response(<<request_status>>) when request_status == 0x01 do
    {request_status, nil}
  end

  def unpack_response(<<request_status, register_id::16>>) when request_status != 0x01 do
    {request_status, register_id}
  end

  defp decode_request_status(request_status) do
    case request_status do
      0x01 -> :success
      0x02 -> {:success, :no_update}
      0x03 -> {:error, :coherency}
      0x04 -> {:error, :invalid_register}
      0x05 -> {:error, :invalid_value}
      0x06 -> {:error, :truncated_value}
      0x07 -> {:error, :access_not_allowed}
      0x08 -> {:error, :generic}
    end
  end
end
