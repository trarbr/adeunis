defmodule Adeunis.Register.ActivationMode do
  defstruct [:mode]

  def decode(<<mode>>) do
    %__MODULE__{
      mode: decode_activation_mode(mode)
    }
  end

  def encode(%__MODULE__{} = register) do
    <<encode_activation_mode(register.mode)>>
  end

  @provisioning_mode %{
    0 => :abp,
    1 => :otaa
  }

  defp decode_activation_mode(provisioning_mode)
  defp encode_activation_mode(provisioning_mode)

  for {value, provisioning_mode} <- @provisioning_mode do
    defp decode_activation_mode(unquote(value)), do: unquote(provisioning_mode)
    defp encode_activation_mode(unquote(provisioning_mode)), do: unquote(value)
  end
end
