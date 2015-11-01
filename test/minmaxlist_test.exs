defmodule MinmaxlistTest do
  use ExUnit.Case
  doctest Minmaxlist

  import Minmaxlist

  test "min list by" do
    result = [1, 2, 3, 4, 5, 6] |> Minmaxlist.min_list_by(&(rem(&1,3)))
    assert result == [3, 6]
    result = [] |> min_list_by(&(rem(&1,3)))
    assert result  == []
  end

  test "max list by" do
    result = [1, 2, 3, 4, 5, 6] |> Minmaxlist.max_list_by(&(rem(&1,3)))
    assert result == [2, 5]
    result = [] |> max_list_by(&(rem(&1,3)))
    assert result  == []
  end

  test "min max list by" do
    result = [1, 2, 3, 4, 5, 6] |> Minmaxlist.min_max_list_by(&(rem(&1,3)))
    assert result == {[3, 6], [2, 5]}
    result = [] |> min_max_list_by(&(rem(&1,3)))
    assert result  == {[], []}
  end

  test "the truth" do
    dataset = [
      %{name: "A", age: 24, income: 4000},
      %{name: "B", age: 22, income: 3300},
      %{name: "C", age: 22, income: 2800},
      %{name: "D", age: 25, income: 5000},
      %{name: "E", age: 22, income: 3300},
      %{name: "F", age: 25, income: 5500},
      %{name: "G", age: 24, income: 4500},
    ]

    result = dataset |> min_list_by(&(&1.age)) |> max_list_by(&(&1.income))
    assert result == [%{name: "B", age: 22, income: 3300}, %{name: "E", age: 22, income: 3300}]

    result = dataset |> min_max_list_by(&(&1.age))
    assert result == {
      [%{name: "B", age: 22, income: 3300}, %{name: "C", age: 22, income: 2800}, %{name: "E", age: 22, income: 3300}],
      [%{name: "D", age: 25, income: 5000}, %{name: "F", age: 25, income: 5500}]
    }
  end
end
