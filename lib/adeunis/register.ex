defmodule Adeunis.Register do
  alias Adeunis.Register

  @register_id_to_module %{
    220 => Register.LorawanOptions,
    221 => Register.ActivationMode,
    300 => Register.KeepAlive,
    [301, 323, 324, 325, 326, 327] => Register.PeriodicTransmitPeriod,
    304 => Register.PINCode,
    306 => Register.ProductMode,
    308 => Register.LEDActivity,
    320 => Register.AlarmSamplingPeriod,
    321 => Register.ModbusLinkConfiguration,
    322 => Register.ModbusSlaveSupplyTime,
    329 => Register.AlarmRepetitionPeriod,
    Range.to_list(330..349) => Register.PeriodicData,
    Range.to_list(350..395//5) => Register.AlarmConfiguration,
    (Range.to_list(351..396//5) ++ Range.to_list(353..398//5)) => Register.AlarmThreshold,
    (Range.to_list(352..397//5) ++ Range.to_list(354..399//5)) => Register.AlarmHysteresis
  }

  for {register_id, module} <- @register_id_to_module,
      is_list(register_id) do
    def decode(content, register_id) when register_id in unquote(register_id) do
      unquote(module).decode(content)
    end
  end

  for {register_id, module} <- @register_id_to_module,
      is_integer(register_id) do
    def decode(content, unquote(register_id)) do
      unquote(module).decode(content)
    end
  end

  for {_register_id, module} <- @register_id_to_module do
    def encode(%unquote(module){} = register) do
      unquote(module).encode(register)
    end
  end
end
