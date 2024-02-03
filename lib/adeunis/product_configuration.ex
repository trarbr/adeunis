defmodule Adeunis.ProductConfiguration do
  defstruct [
    :status,
    :transmission_period_keep_alive,
    :transmission_period_periodic_frame,
    :sampling_period,
    :modbus_config,
    :modbus_slave_supply_time
  ]

  def decode(<<
        0x10,
        status::bytes-1,
        transmission_period_keep_alive::16,
        transmission_period_periodic_frame::16,
        sampling_period::16,
        modbus_config::bytes-1,
        modbus_slave_supply_time::16
      >>) do
    %__MODULE__{
      status: Adeunis.Status.decode(status),
      transmission_period_keep_alive: transmission_period_keep_alive,
      transmission_period_periodic_frame: transmission_period_periodic_frame,
      sampling_period: sampling_period,
      modbus_config: Adeunis.ModbusConfig.decode(modbus_config),
      modbus_slave_supply_time: modbus_slave_supply_time
    }
  end
end
