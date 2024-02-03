defmodule Adeunis.LorawanOptions do
  defstruct [:adr_activation, :duty_cycle_status, :class]

  def decode(<<_::2, class::1, _::2, duty_cycle_status::1, _::1, adr_activation::1>>) do
    %__MODULE__{
      adr_activation: adr_activation(adr_activation),
      duty_cycle_status: duty_cycle_status(duty_cycle_status),
      class: class(class)
    }
  end

  defp adr_activation(adr_activation_bit) do
    case adr_activation_bit do
      0 -> :off
      1 -> :on
    end
  end

  defp duty_cycle_status(duty_cycle_status_bit) do
    case duty_cycle_status_bit do
      0 -> :off
      1 -> :on
    end
  end

  defp class(class_bit) do
    case class_bit do
      0 -> :a
      1 -> :c
    end
  end
end
