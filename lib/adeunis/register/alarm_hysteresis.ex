defmodule Adeunis.Register.AlarmHysteresis do
  defstruct [:hysteresis]

  def decode(<<hysteresis::16>>) do
    %__MODULE__{hysteresis: hysteresis}
  end

  def encode(%__MODULE__{} = register) do
    <<register.hysteresis::16>>
  end
end
