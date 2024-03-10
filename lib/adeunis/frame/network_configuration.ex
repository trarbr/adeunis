defmodule Adeunis.Frame.NetworkConfiguration do
  alias Adeunis.Frame
  alias Adeunis.Register

  defstruct [:status, :lorawan_options, :activation_mode]

  def decode(<<0x20, status::bytes-1, lorawan_options::bytes-1, activation_mode::bytes-1>>) do
    %__MODULE__{
      status: Frame.Status.decode(status),
      lorawan_options: Register.LorawanOptions.decode(lorawan_options),
      activation_mode: Register.ActivationMode.decode(activation_mode)
    }
  end

  def encode(%__MODULE__{} = frame) do
    <<
      0x20,
      Frame.Status.encode(frame.status)::bytes-1,
      Register.LorawanOptions.encode(frame.lorawan_options)::bytes-1,
      Register.ActivationMode.encode(frame.activation_mode)::bytes-1
    >>
  end
end
