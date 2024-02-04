defmodule Adeunis.Codec.NetworkConfiguration do
  alias Adeunis.Codec

  defstruct [:status, :lora_options, :provisioning_mode]

  def decode(<<0x20, status::bytes-1, lora_options::bytes-1, provisioning_mode>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      lora_options: Codec.LorawanOptions.decode(lora_options),
      provisioning_mode: decode_provisioning_mode(provisioning_mode)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x20,
      Codec.Status.encode(frame.status)::bytes-1,
      Codec.LorawanOptions.encode(frame.lora_options)::bytes-1,
      encode_provisioning_mode(frame.provisioning_mode)
    >>
  end

  @provisioning_mode %{
    0 => :abp,
    1 => :otaa
  }

  defp decode_provisioning_mode(provisioning_mode)
  defp encode_provisioning_mode(provisioning_mode)

  for {value, provisioning_mode} <- @provisioning_mode do
    defp decode_provisioning_mode(unquote(value)), do: unquote(provisioning_mode)
    defp encode_provisioning_mode(unquote(provisioning_mode)), do: unquote(value)
  end
end
