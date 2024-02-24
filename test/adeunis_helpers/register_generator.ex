defmodule AdeunisHelpers.RegisterGenerator do
  use ExUnitProperties

  alias Adeunis.Register

  def keep_alive() do
    gen all period <- integer(2..65535) do
      %Register.KeepAlive{period: period * 10}
    end
  end
end
