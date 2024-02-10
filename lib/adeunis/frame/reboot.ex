defmodule Adeunis.Frame.Reboot do
  defstruct [:delay]

  def decode(<<0x48, delay::16>>) do
    %__MODULE__{
      delay: delay
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<0x48, frame.delay::16>>
  end
end
