defmodule AdeunisHelpers.RegisterGenerator do
  use ExUnitProperties

  alias Adeunis.Register

  def alarm_configuration() do
    data_types =
      [:uint16, :int16, :uint32, :int32, :uint32_word_swap, :int32_word_swap]
      |> Enum.map(&constant/1)

    modbus_register_types = Enum.map([:holding, :input], &constant/1)
    active_thresholds = Enum.map([:low, :high, :high_and_low], &constant/1)

    gen all slave_address <- integer(0..247),
            first_register_address <- integer(0..0xFFFF),
            data_type <- one_of(data_types),
            modbus_register_type <- one_of(modbus_register_types),
            active_thresholds <- one_of(active_thresholds) do
      %Register.AlarmConfiguration{
        slave_address: slave_address,
        first_register_address: first_register_address,
        data_type: data_type,
        modbus_register_type: modbus_register_type,
        active_thresholds: active_thresholds
      }
    end
  end

  def alarm_hysteresis() do
    gen all hysteresis <- integer(0..0xFFFF) do
      %Register.AlarmHysteresis{hysteresis: hysteresis}
    end
  end

  def alarm_repetition_period() do
    gen all period <- integer(0..65535) do
      %Register.AlarmRepetitionPeriod{period: period}
    end
  end

  def alarm_sampling_period() do
    gen all period <- integer(1..65535) do
      %Register.AlarmSamplingPeriod{period: period * 10}
    end
  end

  def alarm_threshold() do
    gen all threshold <- integer(0..0xFFFFFFFF) do
      %Register.AlarmThreshold{threshold: threshold}
    end
  end

  def keep_alive() do
    gen all period <- integer(2..65535) do
      %Register.KeepAlive{period: period * 10}
    end
  end

  def led_activity() do
    led_activities = Enum.map([:default, :eco], &constant/1)

    gen all led_activity <- one_of(led_activities) do
      %Register.LEDActivity{led_activity: led_activity}
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

  def modbus_slave_supply_time() do
    gen all supply_time <- integer(0..65535) do
      %Register.ModbusSlaveSupplyTime{supply_time: supply_time * 100}
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

  def periodic_transmit_period() do
    gen all period <- integer(0..65535) do
      %Register.PeriodicTransmitPeriod{period: period * 10}
    end
  end

  def pin_code() do
    gen all code <- one_of([constant(0), integer(1000..9999)]) do
      %Register.PINCode{code: code}
    end
  end

  def product_mode() do
    product_modes = Enum.map([:park, :production], &constant/1)

    gen all product_mode <- one_of(product_modes) do
      %Register.ProductMode{product_mode: product_mode}
    end
  end
end
