defmodule Identicon do
  @moduledoc """
  Tool for generating idonticon`.
  """

  def main(input) do
      input
      |> hash_input()
      |> pick_color()
      |> build_grid()
      |> filter_odd_squares()
  end


  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do

   grid = Enum.filter grid, fn ({code, _index}) ->

      rem(code, 2) == 0

    end

    %Identicon.Image{image | grid: grid}

  end

  def build_grid(%Identicon.Image{hex: hex} = image) do

       grid =
         hex
         |> Enum.chunk_every(3, 3, :discard)
         |> Enum.map(&mirro_row/1)
         |> List.flatten()
         |> Enum.with_index()

         %Identicon.Image{image | grid: grid}
  end

  def mirro_row(chunk) do
    # for chunk <- chunks, [first, second | _third] = chunk do chunk ++ [second, first] end

    [first, second | _third] = chunk
    chunk ++ [second, first]
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
