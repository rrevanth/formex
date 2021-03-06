defmodule Formex.Utils.Map do
  @moduledoc false

  def get_property(map, [key|tail]) do
    get_property Map.get(map, key), tail
  end

  def get_property(value, []) do
    value
  end

end

defmodule Formex.Utils do
  @moduledoc false

  def module?(module) do
    Code.ensure_loaded?(module)
  end

  def implements?(module, behaviour) do
    Enum.member?(module.module_info[:attributes][:behaviour], behaviour)
  end

end

defmodule Formex.Utils.Counter do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, 0)
  end

  def increment(pid) do
    GenServer.call(pid, :increment)
  end

  def reset(pid) do
    GenServer.cast(pid, :reset)
  end

  def handle_call(:increment, _from, state) do
    {:reply, state, state + 1}
  end

  def handle_cast(:reset, _state) do
    {:noreply, 0}
  end
end
