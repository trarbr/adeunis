defmodule Adeunis.Frame.ProductConfiguration do
  alias Adeunis.Frame
  alias Adeunis.Register

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
      status: Frame.Status.decode(status),
      transmission_period_keep_alive: transmission_period_keep_alive,
      transmission_period_periodic_frame: transmission_period_periodic_frame,
      sampling_period: sampling_period,
      modbus_config: Register.ModbusLinkConfiguration.decode(modbus_config),
      modbus_slave_supply_time: modbus_slave_supply_time
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x10,
      Frame.Status.encode(frame.status)::bytes-1,
      frame.transmission_period_keep_alive::16,
      frame.transmission_period_periodic_frame::16,
      frame.sampling_period::16,
      Register.ModbusLinkConfiguration.encode(frame.modbus_config)::bytes-1,
      frame.modbus_slave_supply_time::16
    >>
  end
end
