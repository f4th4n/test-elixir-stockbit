defmodule Bob do
  @spec hey(String.t()) :: String.t()
  def hey(input) do
    input = String.trim(input)

    alpha = String.match?(input, ~r/[[:alpha:]]/)

    res = cond do
      input == "" -> "Fine. Be that way!"
      alpha && input == String.upcase(input) && String.ends_with?(input, "?") -> "Calm down, I know what I'm doing!"
      String.ends_with?(input, "?") -> "Sure."
      alpha && input == String.upcase(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end

    res
  end
end
