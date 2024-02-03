defmodule Adeunis.Status do
  defstruct [
    :configuration_done,
    :low_battery,
    :hardware_error,
    :app_flag_1,
    :app_flag_2,
    :frame_counter
  ]

  def decode(<<
        frame_counter::3,
        app_flag_2::1,
        app_flag_1::1,
        hardware_error::1,
        low_battery::1,
        configuration_done::1
      >>) do
    %__MODULE__{
      frame_counter: frame_counter,
      app_flag_2: app_flag_2,
      app_flag_1: app_flag_1,
      hardware_error: hardware_error,
      low_battery: low_battery,
      configuration_done: configuration_done
    }
  end
end
