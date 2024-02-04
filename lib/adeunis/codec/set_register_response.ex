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

  defp unpack_response(<<request_status>>) when request_status == 0x01 do
    {request_status, nil}
  end

  defp unpack_response(<<request_status, register_id::16>>) do
    {request_status, register_id}
  end

  def encode(%__MODULE__{} = frame) do
    response =
      frame.request_status
      |> encode_request_status()
      |> pack_response(frame.register_id)

    <<
      0x33,
      Codec.Status.encode(frame.status)::bytes-1,
      response::bytes
    >>
  end

  defp pack_response(request_status, _register_id) when request_status == 0x01 do
    <<request_status>>
  end

  defp pack_response(request_status, register_id) do
    <<request_status, register_id::16>>
  end

  @request_status %{
    0x01 => :success,
    0x02 => {:success, :no_update},
    0x03 => {:error, :coherency},
    0x04 => {:error, :invalid_register},
    0x05 => {:error, :invalid_value},
    0x06 => {:error, :truncated_value},
    0x07 => {:error, :access_not_allowed},
    0x08 => {:error, :generic}
  }

  defp decode_request_status(request_status)
  defp encode_request_status(request_status)

  for {value, request_status} <- @request_status do
    defp decode_request_status(unquote(value)), do: unquote(request_status)
    defp encode_request_status(unquote(request_status)), do: unquote(value)
  end
end
