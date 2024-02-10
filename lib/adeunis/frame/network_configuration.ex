defmodule Adeunis.Frame.NetworkConfiguration do
  alias Adeunis.Frame

  defstruct [:status, :lora_options, :provisioning_mode]

  def decode(<<0x20, status::bytes-1, lora_options::bytes-1, provisioning_mode>>) do
    %__MODULE__{
      status: Frame.Status.decode(status),
      lora_options: Frame.LorawanOptions.decode(lora_options),
      provisioning_mode: decode_provisioning_mode(provisioning_mode)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x20,
      Frame.Status.encode(frame.status)::bytes-1,
      Frame.LorawanOptions.encode(frame.lora_options)::bytes-1,
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
