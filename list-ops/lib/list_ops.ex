defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    _count(l, 0)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    _reverse(l, [])
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    _map(l, f, [])
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    _filter(l, f, [])
  end

  @type acc :: any
  @spec foldl(list, acc, (any, acc -> acc)) :: acc
  def foldl(l, acc, f) do
    _reduce(l, acc, f)
  end

  @spec foldr(list, acc, (any, acc -> acc)) :: acc
  def foldr(l, acc, f) do
    reverse(l) |> _reduce(acc, f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    _append(reverse(a), b)
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    _reduce(ll, [], &_append(&1, &2)) |> reverse
  end

  defp _count([], accumulator), do: accumulator
  defp _count([_head | tail], accumulator), do: _count(tail, accumulator + 1)

  defp _reverse([], accumulator), do: accumulator
  defp _reverse([head | tail], accumulator), do: _reverse(tail, [head | accumulator])

  defp _map([], _f, accumulator), do: reverse(accumulator)
  defp _map([head | tail], f, accumulator), do: _map(tail, f, [f.(head) | accumulator])

  defp _filter([], _f, accumulator), do: reverse(accumulator)

  defp _filter([head | tail], f, accumulator) do
    if f.(head) do
      _filter(tail, f, [head | accumulator])
    else
      _filter(tail, f, accumulator)
    end
  end

  defp _reduce([], accumulator, _), do: accumulator

  defp _reduce([head | tail], accumulator, func),
    do: _reduce(tail, func.(head, accumulator), func)

  defp _append([], accumulator), do: accumulator
  defp _append([head | tail], accumulator), do: _append(tail, [head | accumulator])
end
