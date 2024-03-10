defmodule Adeunis.Register.ModbusSlaveSupplyTime do
  defstruct [:supply_time]

  def decode(<<supply_time::16>>) do
    %__MODULE__{supply_time: supply_time * 100}
  end

  def encode(%__MODULE__{} = register) do
    <<div(register.supply_time, 100)::16>>
  end
end
