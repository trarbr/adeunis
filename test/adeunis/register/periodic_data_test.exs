defmodule Adeunis.Register.PeriodicDataTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register.PeriodicData

  test "decode/1 can decode any valid register" do
    assert %PeriodicData{
             slave_address: 10,
             first_register_address: 0x1234,
             associated_periodic_frame: 3,
             modbus_register_type: :holding,
             number_of_registers: 4
           } = PeriodicData.decode(<<10, 0x1234::16, 0x02::3, 0::1, 0x04::4>>)
  end

  property "codec is symmetric" do
    check all frame <- RegisterGenerator.periodic_data() do
      assert frame ==
               frame
               |> PeriodicData.encode()
               |> PeriodicData.decode()
    end
  end
end
