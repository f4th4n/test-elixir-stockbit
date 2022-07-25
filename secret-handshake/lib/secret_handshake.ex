defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when code <= 31 do
    code_str = Integer.to_string(code, 2)
      |> String.trim
      |> String.pad_leading(5, "0")


    action_code = String.split(code_str, "")
      |> Enum.filter(&(&1 != ""))
    action_code_with_index = Enum.with_index(action_code)

    res = Enum.map(action_code_with_index, fn {code, index} ->
      wink = action(code, index == 4, "1_wink")
      double_blink = action(code, index == 3, "2_double blink")
      close_your_eyes = action(code, index == 2, "3_close your eyes")
      jump = action(code, index == 1, "4_jump")

      [wink, double_blink, close_your_eyes, jump]
    end)

    List.flatten(res)
      |> Enum.filter(&(&1 != nil))
      |> reorder
      |> reverse(List.first(action_code))
  end
  def commands(_), do: []

  def reorder(list) do
    list
      |> Enum.sort()
      |> Enum.map(fn v -> String.slice(v, 2..-1) end)
  end

  def reverse(list, "1") do
    Enum.reverse(list)
  end
  def reverse(list, _), do: list

  def action("1", true, word), do: word
  def action(_, _, _), do: nil
end
