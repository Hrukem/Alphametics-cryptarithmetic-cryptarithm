defmodule Alphametics do
  @moduledoc false

  @doc false

  def start() do
    IO.puts("Please wait a few seconds ...")

    #calculating all possible permutations of digits in the range 0..9
    all_permutations = permutation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

    work(all_permutations)
  end

  def work(all_permutations) do
    puzzle = IO.gets("Enter the puzzle: ")
    cond  do
      puzzle == "stop\n" ->
        System.stop 
        :timer.sleep(5000)

      String.contains?(puzzle, "=") ->
        solve(puzzle, all_permutations)
        work(all_permutations)

      true ->
        IO.puts("Invalid input format, missing the character '='")
        work(all_permutations)
    end
  end

  def solve(puzzle, all_permutations) do

    {list_unique, count_unique, list_reverse} = ParseString.parse(puzzle)

    #calculating the list of signatures for all of letters
    signatures = calculation_signatures(list_reverse, list_unique, [])

    #solve an equation of the form 
    #  s1p1 + s2p2 + s3p3 + s4p4 + s5p5 + s6p6 + s7p7 + s8p8 + s9p9 + s10p10 = 0
    #for each signature and permutation
    result_all_variant = 
      signatures_multiplied_by_permutations(all_permutations, signatures, [])
      |> cut_list(count_unique, [])
      |> Enum.uniq()

    #check that zero is not in the first place
    IO.inspect(not_zero_first(puzzle, result_all_variant, list_unique))
  end
 
  defp calculation_signatures(_, [], result) do
    n = Enum.count(result)
    #adding up to 10 elements to the list of signatures
    Enum.reverse(result, List.duplicate(0, 10 - n))
  end

  defp calculation_signatures(list, [h | t], result) do
    calculation_signatures(list, t, [calcul_sign(list, h, [], 0) | result])
  end

  #calculating the signature for a single letter
  defp calcul_sign([], _, _, acc), do: acc
  defp calcul_sign([h1 | t1], letter, list, acc) do

    {list, acc} = cond do

      (h1 == letter) -> 
        {[1 | list], acc}

      (h1 != letter) && (h1 != "+") && (h1 != "-") -> 
        {[0 | list], acc}

      (h1 == "+") -> 
        str = Enum.join(list)
        acc = acc + String.to_integer(str)
        {[], acc}
        
      (h1 == "-") ->
        str = Enum.join(list)
        acc = acc - String.to_integer(str)
        {[], acc}
    end
   calcul_sign(t1, letter, list, acc)
  end

  def permutation([]), do: [[]]
  def permutation(list) do 
    for elem <- list, rest <- permutation(list--[elem]), do: [elem|rest]
  end

  defp signatures_multiplied_by_permutations( [], _sign, result ), do: result
  defp signatures_multiplied_by_permutations( [h|t], signat, result ) do
    acc = multiplication(h, signat, 0)
    result = 
      if (acc == 0), do: [h | result], else: result

    signatures_multiplied_by_permutations(t, signat, result)
  end

  defp multiplication([], [], acc), do: acc
  defp multiplication( [h1|t1], [h2|t2], acc ) do
    multiplication(t1, t2, h1*h2+acc)
  end

  defp cut_list([], _count_unique, list), do: list
  defp cut_list([h | t], count_unique, list) do
    res = Enum.slice(h, 0, count_unique)
    cut_list(t, count_unique, [res | list])
  end

  defp not_zero_first(
    puzzle,
    result_all_variant,
    list_unique) do

      #creating a list of tuples of the first letters with zero
      #for string "SEND + MORE = MONEY" the list will look like this
      # [{"S", 0}, {"M", 0}]
      list_first_letters =
      puzzle
      |> String.replace("+", "-")
      |> String.replace(" ", "")
      |> String.split(~r/-|=/)
      |> first_letters_zero([])

      check(result_all_variant, list_unique, list_first_letters, [])
  end

  defp first_letters_zero([], list), do: list
  defp first_letters_zero([h | t], list) do
    letter = String.at(h, 0)
    list = [{letter, 0} | list]
    first_letters_zero(t, list)
  end

  defp check([], _list_unique, _list_first_letters, list), do: list
  defp check(
    [h_result_all_variant | t_result_all_variant], 
    list_unique,
    list_first_letters,
    list) do
      
      list_zip = Enum.zip(list_unique, h_result_all_variant)

      list = if (
        Enum.count(list_zip) == Enum.count(list_zip -- list_first_letters)
      ) do
          [Enum.into(list_zip, %{}) | list]
      else list
      end

      check(t_result_all_variant, list_unique, list_first_letters, list)
  end
end
