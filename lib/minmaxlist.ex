defmodule Minmaxlist do
  @doc """
  Returns list of entries that gives the minimum value as calculated by the given function.

      iex> [1, 2, 3, 4, 5, 6] |> Minmaxlist.min_list_by(&(rem(&1,3)))
      [3, 6]
  """
  def min_list_by(collection, fun) do
    result = collection |> Enum.reduce(:first, fn
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
      _ -> result |> elem(0) |> Enum.reverse
    end
  end

  @doc """
  Returns list of entries that gives the maximum value as calculated by the given function.

      iex> [1, 2, 3, 4, 5, 6] |> Minmaxlist.max_list_by(&(rem(&1,3)))
      [2, 5]
  """
  def max_list_by(collection, fun) do
    result = collection |> Enum.reduce(:first, fn
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
      _ -> result |> elem(0) |> Enum.reverse
    end
  end

  @doc """
  Returns list of entries that gives the minimum & maximum value as calculated by the given function.

      iex> [1, 2, 3, 4, 5, 6] |> Minmaxlist.min_max_list_by(&(rem(&1,3)))
      {[3, 6], [2, 5]}
  """
  def min_max_list_by(collection, fun) do
    result = collection |> Enum.reduce(:first, fn
      entry, :first ->
        fun_entry = fun.(entry)
        {{[entry], fun_entry}, {[entry], fun_entry}}
      entry, {acc_min={acc_min_entries, acc_min_fun_entry}, acc_max={acc_max_entries, acc_max_fun_entry}} ->
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
      :first -> []
      {result_min, result_max} -> {result_min |> elem(0) |> Enum.reverse, result_max |> elem(0) |> Enum.reverse}
    end
  end
end
