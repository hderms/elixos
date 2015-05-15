alias Elixos.Machine, as: Machine
alias Elixos.Code, as: Code
x = Machine.new
y = %Code{set: [{:push, 1}, {:push, 2}, {:add}, {:halt}]}
Machine.run(x, y)

