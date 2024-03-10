defmodule AdeunisHelpers.FrameGenerator do
  use ExUnitProperties

  alias Adeunis.Frame
  alias AdeunisHelpers.RegisterGenerator

  def alarms() do
    alarm_statuses = Enum.map([:none, :high_threshold, :low_threshold], &constant/1)

    gen all status <- status(),
            alarm_status <- one_of(alarm_statuses),
            slave_address <- integer(0..255),
            register_address <- integer(0x0000..0xFFFF),
            register_value <- one_of([binary(length: 2), binary(length: 4)]) do
      %Frame.Alarms{
        status: status,
        alarm_status: alarm_status,
        slave_address: slave_address,
        register_address: register_address,
        register_value: register_value
      }
    end
  end

  def get_applicative_configuration() do
    constant(%Frame.GetApplicativeConfiguration{})
  end

  def get_network_configuration() do
    constant(%Frame.GetNetworkConfiguration{})
  end

  def get_register_request() do
    gen all registers <- list_of(integer(300..400), min: 1, max: 5) do
      %Frame.GetRegistersRequest{
        registers: registers
      }
    end
  end

  def get_register_response() do
    gen all status <- status(),
            registers <- binary(min_length: 3, max_length: 3 * 4) do
      %Frame.GetRegistersResponse{
        status: status,
        registers: registers
      }
    end
  end

  def keep_alive() do
    gen all status <- status() do
      %Frame.KeepAlive{status: status}
    end
  end

  def network_configuration() do
    gen all status <- status(),
            {_, lorawan_options} <- RegisterGenerator.lorawan_options(),
            {_, activation_mode} <- RegisterGenerator.activation_mode() do
      %Frame.NetworkConfiguration{
        status: status,
        lorawan_options: lorawan_options,
        activation_mode: activation_mode
      }
    end
  end

  def periodic_data() do
    frame_codes = Enum.map([1, 2, 3, 4, 5, 6], &constant/1)

    gen all period <- one_of(frame_codes),
            status <- status(),
            registers <- binary(min_length: 0, max_length: 48) do
      %Frame.PeriodicData{
        period: period,
        status: status,
        registers: registers
      }
    end
  end

  def product_configuration() do
    gen all status <- status(),
            {_, keep_alive} <- RegisterGenerator.keep_alive(),
            {_, periodic_transmit_period} <- RegisterGenerator.periodic_transmit_period(),
            {_, alarm_sampling_period} <- RegisterGenerator.alarm_sampling_period(),
            {_, modbus_link_configuration} <- RegisterGenerator.modbus_link_configuration(),
            {_, modbus_slave_supply_time} <- RegisterGenerator.modbus_slave_supply_time() do
      %Frame.ProductConfiguration{
        status: status,
        keep_alive: keep_alive,
        periodic_transmit_period: periodic_transmit_period,
        alarm_sampling_period: alarm_sampling_period,
        modbus_link_configuration: modbus_link_configuration,
        modbus_slave_supply_time: modbus_slave_supply_time
      }
    end
  end

  def read_modbus_registers_request() do
    register_types = Enum.map([:holding, :input], &constant/1)

    gen all slave_address <- integer(0x00..0xFF),
            register_type <- one_of(register_types),
            first_register_address <- integer(0x0000..0xFFFF),
            number_of_registers <- integer(0x00..0x18) do
      %Frame.ReadModbusRegistersRequest{
        slave_address: slave_address,
        register_type: register_type,
        first_register_address: first_register_address,
        number_of_registers: number_of_registers
      }
    end
  end

  def read_modbus_registers_response() do
    gen all status <- status(),
            registers <- binary(min_length: 0, max_length: 48) do
      %Frame.ReadModbusRegistersResponse{
        status: status,
        registers: registers
      }
    end
  end

  def reboot() do
    gen all delay <- integer(0x0000..0xFFFF) do
      %Frame.Reboot{delay: delay}
    end
  end

  def set_register_request() do
    gen all registers <- list_of(settable_register(), min_length: 1, max_length: 3) do
      %Frame.SetRegistersRequest{registers: registers}
    end
  end

  defp settable_register() do
    gen all {register_id, register} <- RegisterGenerator.register(),
            register_id >= 300 do
      {register_id, register}
    end
  end

  def set_register_response() do
    request_statuses =
      Enum.map(
        [
          :success,
          {:success, :no_update},
          {:error, :coherency},
          {:error, :invalid_register},
          {:error, :invalid_value},
          {:error, :truncated_value},
          {:error, :access_not_allowed},
          {:error, :generic}
        ],
        &constant/1
      )

    gen all status <- status(),
            request_status <- one_of(request_statuses),
            register_id <- integer(0x0000..0xFFFF) do
      case request_status do
        :success ->
          %Frame.SetRegistersResponse{
            status: status,
            request_status: request_status
          }

        _ ->
          %Frame.SetRegistersResponse{
            status: status,
            request_status: request_status,
            register_id: register_id
          }
      end
    end
  end

  def software_version() do
    gen all status <- status(),
            app_version <- version(),
            rtu_version <- version() do
      %Frame.SoftwareVersion{
        status: status,
        app_version: app_version,
        rtu_version: rtu_version
      }
    end
  end

  defp version() do
    gen all major <- integer(0..255),
            minor <- integer(0..255),
            patch <- integer(0..255) do
      %Version{major: major, minor: minor, patch: patch}
    end
  end

  def status() do
    gen all frame_counter <- integer(0b000..0b111),
            app_flag_2 <- integer(0b0..0b1),
            app_flag_1 <- integer(0b0..0b1),
            hardware_error <- integer(0b0..0b1),
            low_battery <- integer(0b0..0b1),
            configuration_done <- integer(0b0..0b1) do
      %Frame.Status{
        frame_counter: frame_counter,
        app_flag_2: app_flag_2,
        app_flag_1: app_flag_1,
        hardware_error: hardware_error,
        low_battery: low_battery,
        configuration_done: configuration_done
      }
    end
  end

  def write_modbus_registers_ack() do
    request_statuses =
      Enum.map([:success, {:error, :generic}, {:error, :invalid_request}], &constant/1)

    gen all status <- status(),
            downlink_framecode <- constant(0x08),
            request_status <- one_of(request_statuses) do
      %Frame.WriteModbusRegistersAck{
        status: status,
        downlink_framecode: downlink_framecode,
        request_status: request_status
      }
    end
  end

  def write_modbus_registers_request() do
    gen all slave_address <- integer(0x00..0xFF),
            first_register_address <- integer(0x0000..0xFFFF),
            number_of_registers <- integer(0x00..0x18),
            register_values <- binary(length: number_of_registers * 2) do
      %Frame.WriteModbusRegistersRequest{
        slave_address: slave_address,
        first_register_address: first_register_address,
        number_of_registers: number_of_registers,
        register_values: register_values
      }
    end
  end

  def frame() do
    one_of([
      alarms(),
      get_applicative_configuration(),
      get_network_configuration(),
      get_register_request(),
      get_register_response(),
      keep_alive(),
      network_configuration(),
      periodic_data(),
      product_configuration(),
      read_modbus_registers_request(),
      read_modbus_registers_response(),
      reboot(),
      set_register_request(),
      set_register_response(),
      software_version(),
      write_modbus_registers_ack(),
      write_modbus_registers_request()
    ])
  end
end
