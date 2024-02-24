defmodule Adeunis.RegisterTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias AdeunisHelpers.RegisterGenerator
  alias Adeunis.Register

  property "codec is symmetric" do
    check all {register_id, register} <- RegisterGenerator.register() do
      assert register ==
               register
               |> Register.encode()
               |> Register.decode(register_id)
    end
  end
end
