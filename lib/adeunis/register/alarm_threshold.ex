defmodule Adeunis.Register.AlarmThreshold do
  defstruct [:threshold]

  def decode(<<threshold::32>>) do
    %__MODULE__{threshold: threshold}
  end

  def encode(%__MODULE__{} = register) do
    <<register.threshold::32>>
  end
end
