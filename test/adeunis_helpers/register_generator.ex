defmodule AdeunisHelpers.RegisterGenerator do
  use ExUnitProperties

  alias Adeunis.Register

  def alarm_configuration() do
    register_ids = Enum.map(Range.to_list(350..395//5), &constant/1)

    data_types =
      [:uint16, :int16, :uint32, :int32, :uint32_word_swap, :int32_word_swap]
      |> Enum.map(&constant/1)

    modbus_register_types = Enum.map([:holding, :input], &constant/1)
    active_thresholds = Enum.map([:low, :high, :high_and_low], &constant/1)

    gen all register_id <- one_of(register_ids),
            slave_address <- integer(0..247),
            first_register_address <- integer(0..0xFFFF),
            data_type <- one_of(data_types),
            modbus_register_type <- one_of(modbus_register_types),
            active_thresholds <- one_of(active_thresholds) do
      {register_id,
       %Register.AlarmConfiguration{
         slave_address: slave_address,
         first_register_address: first_register_address,
         data_type: data_type,
         modbus_register_type: modbus_register_type,
         active_thresholds: active_thresholds
       }}
    end
  end

  def alarm_hysteresis() do
    register_ids = Enum.map(Range.to_list(352..397//5) ++ Range.to_list(354..399//5), &constant/1)

    gen all register_id <- one_of(register_ids),
            hysteresis <- integer(0..0xFFFF) do
      {register_id, %Register.AlarmHysteresis{hysteresis: hysteresis}}
    end
  end

  def alarm_repetition_period() do
    gen all register_id <- constant(329),
            period <- integer(0..65535) do
      {register_id, %Register.AlarmRepetitionPeriod{period: period}}
    end
  end

  def alarm_sampling_period() do
    gen all register_id <- constant(320),
            period <- integer(1..65535) do
      {register_id, %Register.AlarmSamplingPeriod{period: period * 10}}
    end
  end

  def alarm_threshold() do
    register_ids = Enum.map(Range.to_list(351..396//5) ++ Range.to_list(353..398//5), &constant/1)

    gen all register_id <- one_of(register_ids),
            threshold <- integer(0..0xFFFFFFFF) do
      {register_id, %Register.AlarmThreshold{threshold: threshold}}
    end
  end

  def keep_alive() do
    gen all register_id <- constant(300),
            period <- integer(2..65535) do
      {register_id, %Register.KeepAlive{period: period * 10}}
    end
  end

  def led_activity() do
    led_activities = Enum.map([:default, :eco], &constant/1)

    gen all register_id <- constant(308),
            led_activity <- one_of(led_activities) do
      {register_id, %Register.LEDActivity{led_activity: led_activity}}
    end
  end

  def modbus_link_configuration() do
    baud_rates = Enum.map([1200, 2400, 4800, 9600, 19200, 38400, 57600, 115_200], &constant/1)
    parities = Enum.map([:none, :even, :odd], &constant/1)
    bus_types = Enum.map([:rs_485, :rs_232], &constant/1)

    gen all register_id <- constant(321),
            baud_rate <- one_of(baud_rates),
            parity <- one_of(parities),
            stop_bits <- integer(0..1),
            bus_type <- one_of(bus_types) do
      {register_id,
       %Register.ModbusLinkConfiguration{
         baud_rate: baud_rate,
         parity: parity,
         stop_bits: stop_bits + 1,
         bus_type: bus_type
       }}
    end
  end

  def modbus_slave_supply_time() do
    gen all register_id <- constant(322),
            supply_time <- integer(0..65535) do
      {register_id, %Register.ModbusSlaveSupplyTime{supply_time: supply_time * 100}}
    end
  end

  def periodic_data() do
    register_ids = Enum.map(330..349, &constant/1)
    modbus_register_types = Enum.map([:holding, :input], &constant/1)

    gen all register_id <- one_of(register_ids),
            slave_address <- integer(0..0xFF),
            first_register_address <- integer(0..0xFFFF),
            associated_periodic_frame <- integer(0..5),
            modbus_register_type <- one_of(modbus_register_types),
            number_of_registers <- integer(0..0b1111) do
      {register_id,
       %Register.PeriodicData{
         slave_address: slave_address,
         first_register_address: first_register_address,
         associated_periodic_frame: associated_periodic_frame + 1,
         modbus_register_type: modbus_register_type,
         number_of_registers: number_of_registers
       }}
    end
  end

  def periodic_transmit_period() do
    registry_ids = Enum.map([301, 323, 324, 325, 326, 327], &constant/1)

    gen all register_id <- one_of(registry_ids),
            period <- integer(0..65535) do
      {register_id, %Register.PeriodicTransmitPeriod{period: period * 10}}
    end
  end

  def pin_code() do
    gen all register_id <- constant(304),
            code <- one_of([constant(0), integer(1000..9999)]) do
      {register_id, %Register.PINCode{code: code}}
    end
  end

  def product_mode() do
    product_modes = Enum.map([:park, :production], &constant/1)

    # maybe these could return a register id as well, and it could be ignored in most places
    gen all register_id <- constant(306),
            product_mode <- one_of(product_modes) do
      {register_id, %Register.ProductMode{product_mode: product_mode}}
    end
  end

  def register() do
    one_of([
      alarm_configuration(),
      alarm_hysteresis(),
      alarm_repetition_period(),
      alarm_sampling_period(),
      alarm_threshold(),
      keep_alive(),
      led_activity(),
      modbus_link_configuration(),
      modbus_slave_supply_time(),
      periodic_data(),
      periodic_transmit_period(),
      pin_code(),
      product_mode()
    ])
  end
end
