defmodule AlphameticsTest do
  use ExUnit.Case

  test "puzzle" do
    all_permutations = Alphametics.permutation([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])

    #test "puzzle" 
    puzzle = "violin+violin + viola = trio+ sonata"
    solution = 
      [
        %{
          "a" => 9, 
          "i" => 5, 
          "l" => 6, 
          "n" => 2, 
          "o" => 4, 
          "r" => 8, 
          "s" => 7,
          "t" => 1,
          "v" => 3
         },
        %{
          "a" => 8,
          "i" => 5,
          "l" => 6,
          "n" => 2,
          "o" => 4,
          "r" => 9,
          "s" => 7,
          "t" => 1,
          "v" => 3
        }, 
        %{
          "a" => 5,
          "i" => 7,
          "l" => 4,
          "n" => 8,
          "o" => 6,
          "r" => 0,
          "s" => 3,
          "t" => 2,
          "v" => 1
        },
        %{
          "a" => 0,
          "i" => 7,
          "l" => 4,
          "n" => 8,
          "o" => 6,
          "r" => 5,
          "s" => 3,
          "t" => 2,
          "v" => 1
        }
      ]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with three letters" do
    puzzle = "I + BB = ILL"
    solution = [%{"B" => 9, "I" => 1, "L" => 0}] 
    assert Alphametics.solve(puzzle, all_permutations) == solution
    
    #test "solution must have unique value for each letter"
    puzzle = "A = B"
    assert Alphametics.solve(puzzle, all_permutations) == []

    #test "leading zero solution is invalid" do
    puzzle = "ACA + DD = BD"
    assert Alphametics.solve(puzzle, all_permutations) == []

    #test "puzzle with four letters" do
    puzzle = "AS + A = MOM"
    solution = [%{
      "A" => 9,
      "S" => 2,
      "M" => 1,
      "O" => 0
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with six letters" do
    puzzle = "NO + NO + TOO = LATE"
    solution = [%{
      "N" => 7,
      "O" => 4,
      "T" => 9,
      "L" => 1,
      "A" => 0,
      "E" => 2
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with seven letters" do
    puzzle = "HE + SEES + THE = LIGHT"
    solution = [%{
      "E" => 4,
      "G" => 2,
      "H" => 5,
      "I" => 0,
      "L" => 1,
      "S" => 9,
      "T" => 7
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with eight letters" do
    puzzle = "SEND + MORE == MONEY"
    solution = [%{
      "S" => 9,
      "E" => 5,
      "N" => 6,
      "D" => 7,
      "M" => 1,
      "O" => 0,
      "R" => 8,
      "Y" => 2
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with ten letters" do
    puzzle = "AND + A + STRONG + OFFENSE + AS + A + GOOD == DEFENSE"
    solution = [%{
      "A" => 5,
      "D" => 3,
      "E" => 4,
      "F" => 7,
      "G" => 8,
      "N" => 0,
      "O" => 2,
      "R" => 1,
      "S" => 6,
      "T" => 9
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution

    #test "puzzle with ten letters and 199 addends" do
    puzzle =
      "THIS + A + FIRE + THEREFORE + FOR + ALL + HISTORIES + I + TELL + A + " <>
        "TALE + THAT + FALSIFIES + ITS + TITLE + TIS + A + LIE + THE + TALE + " <>
        "OF + THE + LAST + FIRE + HORSES + LATE + AFTER + THE + FIRST + " <>
        "FATHERS + FORESEE + THE + HORRORS + THE + LAST + FREE + TROLL + " <>
        "TERRIFIES + THE + HORSES + OF + FIRE + THE + TROLL + RESTS + AT + " <>
        "THE + HOLE + OF + LOSSES + IT + IS + THERE + THAT + SHE + STORES + " <>
        "ROLES + OF + LEATHERS + AFTER + SHE + SATISFIES + HER + HATE + OFF + " <>
        "THOSE + FEARS + A + TASTE + RISES + AS + SHE + HEARS + THE + LEAST + " <>
        "FAR + HORSE + THOSE + FAST + HORSES + THAT + FIRST + HEAR + THE + " <>
        "TROLL + FLEE + OFF + TO + THE + FOREST + THE + HORSES + THAT + " <>
        "ALERTS + RAISE + THE + STARES + OF + THE + OTHERS + AS + THE + " <>
        "TROLL + ASSAILS + AT + THE + TOTAL + SHIFT + HER + TEETH + TEAR + " <>
        "HOOF + OFF + TORSO + AS + THE + LAST + HORSE + FORFEITS + ITS + " <>
        "LIFE + THE + FIRST + FATHERS + HEAR + OF + THE + HORRORS + THEIR + " <>
        "FEARS + THAT + THE + FIRES + FOR + THEIR + FEASTS + ARREST + AS + " <>
        "THE + FIRST + FATHERS + RESETTLE + THE + LAST + OF + THE + FIRE + " <>
        "HORSES + THE + LAST + TROLL + HARASSES + THE + FOREST + HEART + " <>
        "FREE + AT + LAST + OF + THE + LAST + TROLL + ALL + OFFER + THEIR + " <>
        "FIRE + HEAT + TO + THE + ASSISTERS + FAR + OFF + THE + TROLL + " <>
        "FASTS + ITS + LIFE + SHORTER + AS + STARS + RISE + THE + HORSES + " <>
        "REST + SAFE + AFTER + ALL + SHARE + HOT + FISH + AS + THEIR + " <>
        "AFFILIATES + TAILOR + A + ROOFS + FOR + THEIR + SAFE == FORTRESSES"
    solution = [%{
      "A" => 1,
      "E" => 0,
      "F" => 5,
      "H" => 8,
      "I" => 7,
      "L" => 2,
      "O" => 6,
      "R" => 3,
      "S" => 4,
      "T" => 9
    }]
    assert Alphametics.solve(puzzle, all_permutations) == solution
  end
end
