function init_dominoes(cells)
  dominoes = {}
  checked_colors = {}
  for cell in all(cells) do
    local color = cell.color
    if (color == 0) or in_table(checked_colors, color) then
      goto next
    end

    local first_value = cell.value

    for i=1, #cells do
      local other_cell = cells[i]
      if (not (other_cell == cell)) and (other_cell.color == color) then
        local second_value = other_cell.value
        add(dominoes, init_domino(first_value, second_value))
        add(checked_colors, color)
        break
      end
    end
    ::next::
  end

  return shuffle_table(dominoes)
end

function shuffle_table(table)
  for i = #table, 2, -1 do
    local j = flr(rnd(i)) + 1
    table[i], table[j] = table[j], table[i]
  end
  return table
end

