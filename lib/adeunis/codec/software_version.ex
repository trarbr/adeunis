defmodule Adeunis.Codec.SoftwareVersion do
  alias Adeunis.Codec

  defstruct [:status, :app_version, :rtu_version]

  def decode(<<0x37, status::bytes-1, app_version::bytes-3, rtu_version::bytes-3>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      app_version: decode_version(app_version),
      rtu_version: decode_version(rtu_version)
    }
  end

  def decode_version(<<major, minor, patch>>) do
    %{
      major: major,
      minor: minor,
      patch: patch
    }
  end
end
