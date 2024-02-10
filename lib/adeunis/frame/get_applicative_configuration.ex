defmodule Adeunis.Frame.GetApplicativeConfiguration do
  defstruct []

  def decode(<<0x01>>), do: %__MODULE__{}

  def encode(%__MODULE__{}), do: <<0x01>>
end
