defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    raindrop1 = raindrop(rem(number, 3) == 0, "Pling")
    raindrop2 = raindrop(rem(number, 5) == 0, "Plang")
    raindrop3 = raindrop(rem(number, 7) == 0, "Plong")
    sound = raindrop1 <> raindrop2 <> raindrop3

    if sound == "" do
      Integer.to_string(number)
    else
      sound
    end
  end

  def raindrop(true, sound), do: sound
  def raindrop(false, sound), do: ""
end
