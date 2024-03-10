defmodule Adeunis.Frame.ProductConfiguration do
  alias Adeunis.Frame
  alias Adeunis.Register

  defstruct [
    :status,
    :keep_alive,
    :periodic_transmit_period,
    :alarm_sampling_period,
    :modbus_link_configuration,
    :modbus_slave_supply_time
  ]

  def decode(<<
        0x10,
        status::bytes-1,
        keep_alive::bytes-2,
        periodic_transmit_period::bytes-2,
        alarm_sampling_period::bytes-2,
        modbus_link_configuration::bytes-1,
        modbus_slave_supply_time::bytes-2
      >>) do
    %__MODULE__{
      status: Frame.Status.decode(status),
      keep_alive: Register.KeepAlive.decode(keep_alive),
      periodic_transmit_period: Register.PeriodicTransmitPeriod.decode(periodic_transmit_period),
      alarm_sampling_period: Register.AlarmSamplingPeriod.decode(alarm_sampling_period),
      modbus_link_configuration:
        Register.ModbusLinkConfiguration.decode(modbus_link_configuration),
      modbus_slave_supply_time: Register.ModbusSlaveSupplyTime.decode(modbus_slave_supply_time)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x10,
      Frame.Status.encode(frame.status)::bytes-1,
      Register.KeepAlive.encode(frame.keep_alive)::bytes-2,
      Register.PeriodicTransmitPeriod.encode(frame.periodic_transmit_period)::bytes-2,
      Register.AlarmSamplingPeriod.encode(frame.alarm_sampling_period)::bytes-2,
      Register.ModbusLinkConfiguration.encode(frame.modbus_link_configuration)::bytes-1,
      Register.ModbusSlaveSupplyTime.encode(frame.modbus_slave_supply_time)::bytes-2
    >>
  end
end
