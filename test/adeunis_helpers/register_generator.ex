defmodule AdeunisHelpers.RegisterGenerator do
  use ExUnitProperties

  alias Adeunis.Register

  def keep_alive() do
    gen all period <- integer(2..65535) do
      %Register.KeepAlive{period: period * 10}
    end
  end

  def modbus_link_configuration() do
    baud_rates = Enum.map([1200, 2400, 4800, 9600, 19200, 38400, 57600, 115_200], &constant/1)
    parities = Enum.map([:none, :even, :odd], &constant/1)
    bus_types = Enum.map([:rs_485, :rs_232], &constant/1)

    gen all baud_rate <- one_of(baud_rates),
            parity <- one_of(parities),
            stop_bits <- integer(0..1),
            bus_type <- one_of(bus_types) do
      %Register.ModbusLinkConfiguration{
        baud_rate: baud_rate,
        parity: parity,
        stop_bits: stop_bits + 1,
        bus_type: bus_type
      }
    end
  end

  def periodic_data() do
    modbus_register_types = Enum.map([:holding, :input], &constant/1)

    gen all slave_address <- integer(0..0xFF),
            first_register_address <- integer(0..0xFFFF),
            associated_periodic_frame <- integer(0..5),
            modbus_register_type <- one_of(modbus_register_types),
            number_of_registers <- integer(0..0b1111) do
      %Register.PeriodicData{
        slave_address: slave_address,
        first_register_address: first_register_address,
        associated_periodic_frame: associated_periodic_frame + 1,
        modbus_register_type: modbus_register_type,
        number_of_registers: number_of_registers
      }
    end
  end
end
