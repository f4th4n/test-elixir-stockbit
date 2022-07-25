defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    String.split(sentence, ~r{[\t\n ]})
    |> Enum.reduce(%{}, &collect_word/2)
  end

  defp collect_word(word, curr_map) do
    Map.update(curr_map, word, 1, &(&1 + 1))
  end
end
