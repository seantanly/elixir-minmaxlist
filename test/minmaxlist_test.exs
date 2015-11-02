defmodule MinmaxlistTest do
  use ExUnit.Case
  doctest Minmaxlist


  test "min list by" do
    assert Minmaxlist.min_list_by([1, 2, 3, 4, 5, 6], fn(x) -> rem(x, 3) end) == [3, 6]
    assert Minmaxlist.min_list_by([], fn(x) -> rem(x, 3) end) == []
  end

  test "max list by" do
    assert Minmaxlist.max_list_by([1, 2, 3, 4, 5, 6], fn(x) -> rem(x, 3) end) == [2, 5]
    assert Minmaxlist.max_list_by([], fn(x) -> rem(x, 3) end) == []
  end

  test "min max list by" do
    assert Minmaxlist.min_max_list_by([1, 2, 3, 4, 5, 6], fn(x) -> rem(x, 3) end) == {[3, 6], [2, 5]}
    assert Minmaxlist.min_max_list_by([], fn(x) -> rem(x, 3) end) == {[], []}
  end

  test "README examples" do
    import Minmaxlist
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
