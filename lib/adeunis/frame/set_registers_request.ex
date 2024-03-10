defmodule Adeunis.Frame.SetRegistersRequest do
  alias Adeunis.Register

  defstruct [:registers]

  def decode(<<0x41, registers::bytes>>) do
    %__MODULE__{
      registers: decode_registers(registers)
    }
  end

  defp decode_registers(registers, acc \\ [])

  defp decode_registers(<<>>, acc) do
    Enum.reverse(acc)
  end

  defp decode_registers(<<register_id, rest::bytes>>, acc) do
    register_id = register_id + 300
    size = register_size(register_id)
    <<register::bytes-size(size), rest::bytes>> = rest
    decoded_register = Register.decode(register, register_id)
    decode_registers(rest, [{register_id, decoded_register} | acc])
  end

  @one_byte_registers [306, 321]
  @two_byte_registers [300, 301, 304, 320] ++
                        Range.to_list(322..327) ++
                        [329] ++ Range.to_list(352..397//5) ++ Range.to_list(354..399//5)
  @four_byte_registers [308] ++
                         Range.to_list(330..349) ++
                         Range.to_list(350..395//5) ++
                         Range.to_list(351..396//5) ++ Range.to_list(353..398//5)

  defp register_size(register_id) when register_id in @one_byte_registers, do: 1
  defp register_size(register_id) when register_id in @two_byte_registers, do: 2
  defp register_size(register_id) when register_id in @four_byte_registers, do: 4

  def encode(%__MODULE__{} = frame) do
    encoded_registers =
      for {register_id, register} <- frame.registers, into: <<>> do
        <<register_id - 300, Register.encode(register)::bytes>>
      end

    <<0x41, encoded_registers::bytes>>
  end
end
