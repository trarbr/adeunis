defmodule Adeunis.Frame.SoftwareVersion do
  alias Adeunis.Frame

  defstruct [:status, :app_version, :rtu_version]

  def decode(<<0x37, status::bytes-1, app_version::bytes-3, rtu_version::bytes-3>>) do
    %__MODULE__{
      status: Frame.Status.decode(status),
      app_version: decode_version(app_version),
      rtu_version: decode_version(rtu_version)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x37,
      Frame.Status.encode(frame.status)::bytes-1,
      encode_version(frame.app_version)::bytes,
      encode_version(frame.rtu_version)::bytes
    >>
  end

  defp decode_version(<<major, minor, patch>>) do
    %Version{
      major: major,
      minor: minor,
      patch: patch
    }
  end

  defp encode_version(%Version{} = version) do
    <<version.major, version.minor, version.patch>>
  end
end
