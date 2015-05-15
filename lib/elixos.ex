defmodule Elixos do


  defmodule Instruction do

  end

end

defmodule Elixos.Code do
  defstruct set: []
end

defmodule Elixos.Machine do
  alias __MODULE__, as: Machine
  alias Elixos.Processor, as: Processor
  alias Elixos.Code, as: Code
  defstruct  stack: [], registers:  Enum.into([a: 0, b: 0], HashDict.new)
  def new do
    %Machine{}
  end

  def incr(machine = %Machine{}, register)
  when is_bitstring(register)
  and bit_size(register) == 1
  do
    stored_value = Dict.get(machine.registers, register) || 0
    %{machine| registers: Dict.put(machine.registers, register, stored_value + 1)}
  end

  def set(machine = %Machine{}, register, value)
  when is_bitstring(register)
  and bit_size(register) == 1
  do
    %{machine| registers: Dict.put(machine.registers, register, value)}
  end

  def add(machine = %Machine{}) do
    {machine, a} = Machine.pop(machine)
    {machine, b} = Machine.pop(machine)
    Machine.push(machine, a + b)
  end

  def push(machine = %Machine{}, el)
  when is_number(el)
  do
    %{machine| stack: [el | machine.stack]}
  end

  def pop(machine = %Machine{stack: []}) do
    {machine, nil}
  end

  def pop(machine = %Machine{stack: [head | tail]}) do
    { %Machine{machine| stack: tail}, head}
  end

  def halt(machine = %Machine{}) do

    IO.puts "HALT"
  end
  def run(machine, code = %Code{set: [next|rest = []]}) do
    Processor.execute(machine, next)
    IO.puts "fin."
    IO.inspect machine
  end
  def run(machine, code = %Code{set: [next|rest]}) do
    machine = Processor.execute(machine, next)
    run(machine, %{code | set: rest})
  end
end

defmodule Elixos.Language do
  def tokenize() do

  end

end

defmodule Elixos.Processor do
  alias Elixos.Machine, as: Machine

  def execute(machine , instruction ) do
    case instruction do
      {:halt} ->
        Machine.halt(machine)
      {:incr, register} ->
        Machine.incr(machine, register)
      {:set, register, value} ->
        Machine.set(machine, register, value)
      {:add} ->
        Machine.add(machine)
      {:push, value} ->
        Machine.push(machine,  value)
      {:pop} ->
        Machine.push(machine)
    end
  end
end
