defmodule Adeunis.SetRegisterResponseTest do
  use ExUnit.Case, async: true

  alias Adeunis.SetRegisterResponse

  test "decode/1" do
    %SetRegisterResponse{
      status: %Adeunis.Status{},
      request_status: {:error, :invalid_register},
      register_id: 0x0140
    } = SetRegisterResponse.decode(<<0x33, 0x80, 0x04, 0x0140::16>>)

    %SetRegisterResponse{
      status: %Adeunis.Status{},
      request_status: :success,
      register_id: nil
    } = SetRegisterResponse.decode(<<0x33, 0x80, 0x01>>)
  end
end
