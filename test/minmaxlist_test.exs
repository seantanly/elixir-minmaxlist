defmodule MinmaxlistTest do
  use ExUnit.Case
  doctest Minmaxlist

  test "min list by" do
    list = ["a", "b", "aa", "bb", "bbb", "aaa"]
    assert Minmaxlist.min_list_by(list, &String.length(&1)) == ["a", "b"]

    assert Minmaxlist.min_list_by([], &String.length(&1)) == []
  end

  test "max list by" do
    list = ["a", "b", "aa", "bb", "bbb", "aaa"]
    assert Minmaxlist.max_list_by(list, &String.length(&1)) == ["bbb", "aaa"]

    assert Minmaxlist.max_list_by([], &String.length(&1)) == []
  end

  test "min max list by" do
    list = ["a", "b", "aa", "bb", "bbb", "aaa"]
    assert Minmaxlist.min_max_list_by(list, &String.length(&1)) == {["a", "b"], ["bbb", "aaa"]}

    assert Minmaxlist.min_max_list_by([], &String.length(&1)) == {[], []}
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
      %{name: "G", age: 24, income: 4500}
    ]

    result = dataset |> min_list_by(& &1.age) |> max_list_by(& &1.income)
    assert result == [%{name: "B", age: 22, income: 3300}, %{name: "E", age: 22, income: 3300}]

    result = dataset |> min_max_list_by(& &1.age)

    expected_min_list = [
      %{name: "B", age: 22, income: 3300},
      %{name: "C", age: 22, income: 2800},
      %{name: "E", age: 22, income: 3300}
    ]

    expected_max_list = [%{name: "D", age: 25, income: 5000}, %{name: "F", age: 25, income: 5500}]

    assert result == {expected_min_list, expected_max_list}
  end
end
