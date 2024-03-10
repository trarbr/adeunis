defmodule Adeunis.Register.AlarmRepetitionPeriod do
  defstruct [:period]

  def decode(<<period::16>>) do
    %__MODULE__{period: period}
  end

  def encode(%__MODULE__{} = register) do
    <<register.period::16>>
  end
end
