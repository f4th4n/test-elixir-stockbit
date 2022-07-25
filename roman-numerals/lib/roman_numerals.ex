defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    digits =
      number
      |> Integer.to_string()
      |> String.split("", trim: true)

    convert(digits)
  end

  def convert(digits) do
    digits = Enum.map(digits, fn v -> String.to_integer(v) end)

    res =
      Enum.map([2, 1, 0], fn i ->
        ### roman_num = (key[+digits.pop() + (i * 10)] || "") + roman_num;
        ### return Array(+digits.join("") + 1).join("M") + roman_num;

        last = List.last(digits)
        i_times_10 = i * 10
        index = last + i_times_10
        roman_num = get_roman_val(index)
        roman_num
      end)

    res
  end

  def get_roman_val(key) do
    roman_key = [
      "",
      "C",
      "CC",
      "CCC",
      "CD",
      "D",
      "DC",
      "DCC",
      "DCCC",
      "CM",
      "",
      "X",
      "XX",
      "XXX",
      "XL",
      "L",
      "LX",
      "LXX",
      "LXXX",
      "XC",
      "",
      "I",
      "II",
      "III",
      "IV",
      "V",
      "VI",
      "VII",
      "VIII",
      "IX"
    ]

    if Enum.at(roman_key, key) != nil do
      Enum.at(roman_key, key)
    else
      ""
    end
  end
end
