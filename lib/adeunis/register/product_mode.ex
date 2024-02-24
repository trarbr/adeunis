defmodule Adeunis.Register.ProductMode do
  defstruct [:product_mode]

  def decode(<<product_mode>>) do
    %__MODULE__{product_mode: decode_product_mode(product_mode)}
  end

  def encode(%__MODULE__{} = register) do
    <<encode_product_mode(register.product_mode)>>
  end

  @product_mode %{
    0 => :park,
    1 => :production
  }

  defp decode_product_mode(product_mode)
  defp encode_product_mode(product_mode)

  for {value, product_mode} <- @product_mode do
    defp decode_product_mode(unquote(value)), do: unquote(product_mode)
    defp encode_product_mode(unquote(product_mode)), do: unquote(value)
  end
end
