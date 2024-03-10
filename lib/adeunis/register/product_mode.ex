defmodule Adeunis.Register.ProductMode do
  defstruct [:mode]

  def decode(<<mode>>) do
    %__MODULE__{mode: decode_mode(mode)}
  end

  def encode(%__MODULE__{} = register) do
    <<encode_mode(register.mode)>>
  end

  @mode %{
    0 => :park,
    1 => :production
  }

  defp decode_mode(mode)
  defp encode_mode(mode)

  for {value, mode} <- @mode do
    defp decode_mode(unquote(value)), do: unquote(mode)
    defp encode_mode(unquote(mode)), do: unquote(value)
  end
end
