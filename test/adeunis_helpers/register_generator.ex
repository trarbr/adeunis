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
end
