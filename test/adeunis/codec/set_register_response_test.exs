defmodule Adeunis.Codec.SetRegisterResponseTest do
  use ExUnit.Case, async: true

  alias Adeunis.Codec.SetRegisterResponse
  alias Adeunis.Codec.Status

  test "decode/1" do
    %SetRegisterResponse{
      status: %Status{},
      request_status: {:error, :invalid_register},
      register_id: 0x0140
    } = SetRegisterResponse.decode(<<0x33, 0x80, 0x04, 0x0140::16>>)

    %SetRegisterResponse{
      status: %Status{},
      request_status: :success,
      register_id: nil
    } = SetRegisterResponse.decode(<<0x33, 0x80, 0x01>>)
  end
end
