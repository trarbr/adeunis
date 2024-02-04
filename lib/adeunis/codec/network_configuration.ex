defmodule Adeunis.Codec.NetworkConfiguration do
  alias Adeunis.Codec

  defstruct [:status, :lora_options, :provisioning_mode]

  def decode(<<0x20, status::bytes-1, lora_options::bytes-1, provisioning_mode>>) do
    %__MODULE__{
      status: Codec.Status.decode(status),
      lora_options: Codec.LorawanOptions.decode(lora_options),
      provisioning_mode: provisioning_mode(provisioning_mode)
    }
  end

  defp provisioning_mode(provisioning_mode_bits) do
    case provisioning_mode_bits do
      0 -> :abp
      1 -> :otaa
    end
  end
end
