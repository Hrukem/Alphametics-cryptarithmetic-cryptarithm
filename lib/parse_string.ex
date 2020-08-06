defmodule ParseString do
  @moduledoc false

  def parse(string) do
    #from the puzzle string, we get a list of the form:
    #  ["a", "+", "b", "c", "+", "d", "e", "-", "f", "g", "h"]
    parse_string(string)

    #from the list we get a tuple containing
    #list of uneque letters of the form:
    #  ["a", "b", "c", "d", "e", "f", "g", "h"],
    #  number of elements list_unique and an inverted list
    |> unique_list()
  end
  
  defp parse_string(string) do
    list = 
      string
      |> String.trim()
      |> String.trim("\"")
      |> String.split("=", trim: true)
    
    if (Enum.count(list) == 1) do
      IO.puts("Invalid input, there is nothing after the '=' sign")
      Alphametics.start()
    end

    list1 = 
      list
      |> List.first()
      |> String.split("", trim: true)
      |> Enum.reject(fn x -> x == " " end)
      |> insert_sign("+")

    list2 = 
      list
      |> List.last()
      |> String.split("", trim: true)
      |> Enum.reject(fn x -> x == " " end)
      |> Enum.map(fn x -> change_sign(x) end)
      |> insert_sign("-")

    List.flatten(list1, list2)      
  end

  defp insert_sign(list, sign)do
    if List.first(list) == "-" || List.first(list) == "+",
      do: list,
      else: List.insert_at(list, 0, sign)
  end

  defp change_sign(x) do
    case (x) do
      "-" -> "+"
      "+" -> "-"
       _  -> x
    end
  end

  defp unique_list(list) do
   list_unique = 
     list 
     |> Enum.uniq_by(fn x -> x end)
     |> List.delete("+")
     |> List.delete("-")
   
   #if there are more than 10 letters stop the program
   count_unique = Enum.count(list_unique)
   if (count_unique > 10) do
     IO.puts("There are more than 10 unknown letters in the puzzle")
     Alphametics.start()
   end

   {list_unique, count_unique, Enum.reverse(list)}
  end
end 
