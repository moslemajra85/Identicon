defmodule Identicon do
  @moduledoc """
  Tool for generating idonticon`.
  """

  def main(input) do
      input |> hash_input() |> pick_color()
  end


  def pick_color(   %Identicon.Image{hex: [r, g,b | _tail]} = image) do
        #  %Identicon.Image{hex: hext_list} = image
        #  [r, g, b | _] = hext_list
        #  [r, g, b]



       %Identicon.Image{image | color: {r, g, b}}

  end

  def hash_input(input) do

   hex = :crypto.hash(:md5, input) |> :binary.bin_to_list()

   %Identicon.Image{hex: hex}

  end



end
