defmodule Adeunis.Register.PeriodicTransmitPeriod do
  defstruct [:period]

  def decode(<<period::16>>) do
    %__MODULE__{period: period * 10}
  end

  def encode(%__MODULE__{} = register) do
    <<div(register.period, 10)::16>>
  end
end
