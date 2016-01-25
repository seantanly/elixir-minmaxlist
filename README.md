Minmaxlist
========
[![Build Status](https://travis-ci.org/seantanly/elixir-minmaxlist.svg?branch=master)](https://travis-ci.org/seantanly/elixir-minmaxlist)
[![Hex.pm Version](http://img.shields.io/hexpm/v/minmaxlist.svg?style=flat)](https://hex.pm/packages/minmaxlist)

Elixir library extending `Enum.min_by/2`, `Enum.max_by/2` and `Enum.min_max_by/2` to return a list of results instead of just one.

This enables searching for all matching results based multiple min/max value criteria. See [Examples](#examples).


## Documentation

API documentation is available at [http://hexdocs.pm/minmaxlist](http://hexdocs.pm/minmaxlist)

## Adding Minmaxlist To Your Project

To use Minmaxlist with your projects, edit your `mix.exs` file and add it as a dependency:

```elixir
defp deps do
  [
    {:minmaxlist, "~> x.x.x"},
  ]
end
```

## Examples

Minmaxlist is designed to assist in filtering result sets by min/max value while returning list of results that matches the requirement. This is especially useful for example, 


Find the youngest people with highest income.

```elixir
import Minmaxlist
[
  %{name: "A", age: 24, income: 4000},
  %{name: "B", age: 22, income: 3300},
  %{name: "C", age: 22, income: 2800},
  %{name: "D", age: 25, income: 5000},
  %{name: "E", age: 22, income: 3300},
  %{name: "F", age: 25, income: 5500},
  %{name: "G", age: 24, income: 4500},
] |> min_list_by(&(&1.age)) |> max_list_by(&(&1.income))
# => [%{name: "B", age: 22, income: 3300}, %{name: "E", age: 22, income: 3300}]
```

Find the youngest and oldest people,

```elixir
import Minmaxlist
[
  %{name: "A", age: 24, income: 4000},
  %{name: "B", age: 22, income: 3300},
  %{name: "C", age: 22, income: 2800},
  %{name: "D", age: 25, income: 5000},
  %{name: "E", age: 22, income: 3300},
  %{name: "F", age: 25, income: 5500},
  %{name: "G", age: 24, income: 4500},
] |> min_max_list_by(&(&1.age)) 
# => {
#   [%{name: "B", age: 22, income: 3300}, %{name: "C", age: 22, income: 2800}, %{name: "E", age: 22, income: 3300}],
#   [%{name: "D", age: 25, income: 5000}, %{name: "F", age: 25, income: 5500}]
# }
```

