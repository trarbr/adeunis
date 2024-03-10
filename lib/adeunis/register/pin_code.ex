defmodule Adeunis.Register.PINCode do
  defstruct [:code]

  def decode(<<code::16>>) do
    %__MODULE__{code: code}
  end

  def encode(%__MODULE__{} = register) do
    <<register.code::16>>
  end
end
