defmodule Minmaxlist do
  @moduledoc """
  Adds `min_list_by/2`, `max_list_by/2` and `min_max_list_by/2` that's not in `Enum`.
  """

  import Enum, only: [reduce: 3]

  @type t :: Enumerable.t
  @type element:: any

  @doc """
  Returns list of the biggest elements in the enumerable as calculated by the given function.

  Returns empty list if the enumerable is empty.

  ## Examples

      iex> Minmaxlist.max_list_by(["a", "b", "aa", "bb", "bbb", "aaa"], fn(x) -> String.length(x) end)
      ["bbb", "aaa"]

      iex> Minmaxlist.max_list_by([], fn(x) -> String.length(x) end)
      []

  """
  @spec max_list_by(t, (element -> any)) :: [element]
  def max_list_by(enumerable, fun) do
    result = enumerable |> reduce(:first, fn
      entry, :first ->
        fun_entry = fun.(entry)
        {[entry], fun_entry}
      entry, {acc_entries, acc_fun_entry} ->
        fun_entry = fun.(entry)
        cond do
          fun_entry == acc_fun_entry -> {[entry|acc_entries], fun_entry}
          fun_entry > acc_fun_entry -> {[entry], fun_entry}
          true -> {acc_entries, acc_fun_entry}
        end
    end)
    case result do
      :first -> []
      _ -> result |> elem(0) |> :lists.reverse
    end
  end

  @doc """
  Returns list of the smallest elements in the enumerable as calculated by the given function.

  Returns empty list if the enumerable is empty.

  ## Examples

      iex> Minmaxlist.min_list_by(["a", "b", "aa", "bb", "bbb", "aaa"], fn(x) -> String.length(x) end)
      ["a", "b"]

      iex> Minmaxlist.min_list_by([], fn(x) -> String.length(x) end)
      []

  """
  @spec min_list_by(t, (element -> any)) :: [element]
  def min_list_by(enumerable, fun) do
    result = enumerable |> reduce(:first, fn
      entry, :first ->
        fun_entry = fun.(entry)
        {[entry], fun_entry}
      entry, {acc_entries, acc_fun_entry} ->
        fun_entry = fun.(entry)
        cond do
          fun_entry == acc_fun_entry -> {[entry|acc_entries], fun_entry}
          fun_entry < acc_fun_entry -> {[entry], fun_entry}
          true -> {acc_entries, acc_fun_entry}
        end
    end)
    case result do
      :first -> []
      _ -> result |> elem(0) |> :lists.reverse
    end
  end

  @doc """
  Returns a tuple with list of smallest elements and list of biggest elements in the enumerable as calculated by the given function.

  Returns a tuple of two empty lists if the enumerable is empty.

  ## Examples

      iex> Minmaxlist.min_max_list_by(["a", "b", "aa", "bb", "bbb", "aaa"], fn(x) -> String.length(x) end)
      {["a", "b"], ["bbb", "aaa"]}

      iex> Minmaxlist.min_max_list_by([], fn(x) -> String.length(x) end)
      {[], []}

  """
  @spec min_max_list_by(t, (element -> any)) :: {[element], [element]}
  def min_max_list_by(enumerable, fun) do
    result = enumerable |> reduce(:first, fn
      entry, :first ->
        fun_entry = fun.(entry)
        {{[entry], fun_entry}, {[entry], fun_entry}}
      entry, {{acc_min_entries, acc_min_fun_entry} = acc_min, {acc_max_entries, acc_max_fun_entry} = acc_max} ->
        fun_entry = fun.(entry)
        acc_min = cond do
          fun_entry == acc_min_fun_entry -> {[entry|acc_min_entries], fun_entry}
          fun_entry < acc_min_fun_entry -> {[entry], fun_entry}
          true -> acc_min
        end
        acc_max = cond do
          fun_entry == acc_max_fun_entry -> {[entry|acc_max_entries], fun_entry}
          fun_entry > acc_max_fun_entry -> {[entry], fun_entry}
          true -> acc_max
        end
        {acc_min, acc_max}
    end)
    case result do
      :first -> {[], []}
      {result_min, result_max} -> {result_min |> elem(0) |> :lists.reverse, result_max |> elem(0) |> :lists.reverse}
    end
  end

end
