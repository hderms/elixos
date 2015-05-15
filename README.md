
Summary
====
Simple virtual machine to explore simulating state in functional languages.

Example
=====
``` elixir
# $> iex -S mix
alias Elixos.Machine, as: Machine
alias Elixos.Code, as: Code
x = Machine.new
y = %Code{set: [{:push, 1}, {:push, 2}, {:add}, {:halt}]}
Machine.run(x, y)
```

