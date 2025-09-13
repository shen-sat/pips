function init_domino(value_one, value_two)
  -- Domino object with state and methods will go here
  -- Placeholder for now
  values = {value_one, value_two}
  local index = flr(rnd(2)) + 1

  local first_value = values[index]
  local second_value = values[3 - index]

  return {first_value, second_value}
end
