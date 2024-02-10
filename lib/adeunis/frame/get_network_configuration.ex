defmodule Adeunis.Frame.GetNetworkConfiguration do
  defstruct []

  def decode(<<0x02>>), do: %__MODULE__{}

  def encode(%__MODULE__{}), do: <<0x02>>
end
