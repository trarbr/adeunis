defmodule AdeunisHelpers.FrameGenerator do
  use ExUnitProperties

  def alarms() do
    gen all status <- status(),
            alarm_status <- integer(0x00..0x02),
            slave_address <- integer(0..255),
            register_address <- integer(0x0000..0xFFFF),
            register_value <- one_of([binary(length: 2), binary(length: 4)]) do
      <<
        0x45,
        status::bytes-1,
        alarm_status,
        slave_address,
        register_address::16,
        register_value::bytes
      >>
    end
  end

  def get_applicative_configuration() do
    constant(<<0x01>>)
  end

  def get_network_configuration() do
    constant(<<0x02>>)
  end

  def get_register_response() do
    gen all status <- status(),
            registers <- binary(min_length: 0, max_length: 28) do
      <<0x31, status::bytes-1, registers::bytes>>
    end
  end

  def keep_alive() do
    gen all status <- status() do
      <<0x30, status::bytes-1>>
    end
  end

  def lorawan_options() do
    gen all class <- integer(0b0..0b1),
            duty_cycle_status <- integer(0..1),
            adr_activation <- integer(0..1) do
      <<0::2, class::1, 0::2, duty_cycle_status::1, 0::1, adr_activation::1>>
    end
  end

  def modbus_config() do
    gen all baud_rate <- integer(0..7),
            parity <- integer(0..2),
            stop_bits <- integer(0..1),
            bus_type <- integer(0..1) do
      <<baud_rate::4, parity::2, stop_bits::1, bus_type::1>>
    end
  end

  def network_configuration() do
    gen all status <- status(),
            lora_options <- lorawan_options(),
            provisioning_mode <- integer(0..1) do
      <<0x20, status::bytes-1, lora_options::bytes-1, provisioning_mode>>
    end
  end

  def periodic_data() do
    frame_codes =
      Adeunis.Frame.PeriodicData.frame_codes()
      |> Enum.map(fn frame_code -> constant(frame_code) end)

    gen all period <- one_of(frame_codes),
            status <- status(),
            registers <- binary(min_length: 0, max_length: 28) do
      <<period, status::bytes-1, registers::bytes>>
    end
  end

  def product_configuration() do
    gen all status <- status(),
            transmission_keep_alive_time <- integer(0x0000..0xFFFF),
            transmission_period_periodic_frame <- integer(0x0000..0xFFFF),
            sampling_period <- integer(0x0000..0xFFFF),
            modbus_config <- modbus_config(),
            modbus_slave_supply_time <- integer(0x0000..0xFFFF) do
      <<
        0x10,
        status::bytes-1,
        transmission_keep_alive_time::16,
        transmission_period_periodic_frame::16,
        sampling_period::16,
        modbus_config::bytes-1,
        modbus_slave_supply_time::16
      >>
    end
  end

  def read_modbus_registers_response() do
    gen all status <- status(),
            registers <- binary(min_length: 0, max_length: 24) do
      <<0x5E, status::bytes-1, registers::bytes>>
    end
  end

  def set_register_response() do
    gen all status <- status(),
            request_status <- integer(0x01..0x08),
            register_id <- integer(0x0000..0xFFFF) do
      case request_status do
        0x01 -> <<0x33, status::bytes-1, request_status>>
        _ -> <<0x33, status::bytes-1, request_status, register_id::16>>
      end
    end
  end

  def software_version() do
    gen all status <- status(),
            app_version <- integer(0x000000..0xFFFFFF),
            rtu_version <- integer(0x000000..0xFFFFFF) do
      <<0x37, status::bytes-1, app_version::24, rtu_version::24>>
    end
  end

  def status() do
    gen all frame_counter <- integer(0b000..0b111),
            app_flag_2 <- integer(0b0..0b1),
            app_flag_1 <- integer(0b0..0b1),
            hardware_error <- integer(0b0..0b1),
            low_battery <- integer(0b0..0b1),
            configuration_done <- integer(0b0..0b1) do
      <<
        frame_counter::3,
        app_flag_2::1,
        app_flag_1::1,
        hardware_error::1,
        low_battery::1,
        configuration_done::1
      >>
    end
  end

  def write_modbus_registers_ack() do
    gen all status <- status(),
            request_status <- integer(0x01..0x03) do
      <<0x2F, status::bytes-1, 0x08, request_status>>
    end
  end

  def frame() do
    one_of([
      alarms(),
      get_applicative_configuration(),
      get_network_configuration(),
      get_register_response(),
      keep_alive(),
      network_configuration(),
      periodic_data(),
      product_configuration(),
      read_modbus_registers_response(),
      set_register_response(),
      software_version(),
      write_modbus_registers_ack()
    ])
  end
end
