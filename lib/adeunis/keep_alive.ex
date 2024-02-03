defmodule Adeunis.KeepAlive do
  defstruct [:status]

  def decode(<<0x30, status::bytes-1>>) do
    %__MODULE__{
      status: Adeunis.Status.decode(status)
    }
  end
end
