defmodule Change do
  @doc """
    Determine the least number of coins to be given to the user such
    that the sum of the coins' value would equal the correct amount of change.
    It returns {:error, "cannot change"} if it is not possible to compute the
    right amount of coins. Otherwise returns the tuple {:ok, list_of_coins}

    ## Examples

      iex> Change.generate([5, 10, 15], 3)
      {:error, "cannot change"}

      iex> Change.generate([1, 5, 10], 18)
      {:ok, [1, 1, 1, 5, 10]}

  """

  def generate(_, target) when target < 0, do: {:error, "cannot change"}
  def generate(_, 0), do: {:ok, []}

  def generate(coins, target) do
    for_change = fn coins, target, index ->
      coins
      |> Enum.filter(fn coin -> index[target - coin] end)
      |> Enum.map(fn coin -> [coin | index[target - coin]] end)
      |> Enum.min_by(&Enum.count/1, fn -> nil end)
      |> update_index(target, index)
    end

    1..target
    |> Enum.reduce(%{0 => []}, &for_change.(coins, &1, &2))
    |> Map.get(target)
    |> validate
  end

  defp update_index([], _, index), do: index
  defp update_index(coins, target, index), do: Map.put(index, target, coins)

  defp validate(nil), do: {:error, "cannot change"}
  defp validate(change), do: {:ok, change}
end
