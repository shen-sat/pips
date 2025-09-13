function init_board()
  local board = {}
  for x=1, GRID_W do
    board[x] = {}
    for y=1, GRID_H do
      board[x][y] = {color=0}
    end
  end
  -- this will return the most top-left non-zero datum
  function board:get_board_anchor()
    local min_x, min_y = GRID_W, GRID_H
    for x=1, GRID_W do
      for y=1, GRID_H do
        if board[x][y] and board[x][y].color and board[x][y].color > 0 then
          if x < min_x then min_x = x end
          if y < min_y then min_y = y end
        end
      end
    end
    return min_x, min_y
  end
  -- this will decide the placement of dominoes on the board
  init_data(board)
  
  return board
end

function init_data(board)
  local success = false
  for attempt = 1, 20 do -- MAX_ATTEMPTS
    -- Clear board
    for x=1, GRID_W do
      for y=1, GRID_H do
        board[x][y].color = 0
      end
    end

    -- 1. Place the first domino randomly
    local start_x, start_y = flr(rnd(GRID_W)) + 1, flr(rnd(GRID_H)) + 1
    local orient = flr(rnd(2)) -- 0 for horizontal, 1 for vertical
    if orient == 0 and start_x == GRID_W then start_x = GRID_W - 1 end
    if orient == 1 and start_y == GRID_H then start_y = GRID_H - 1 end

    board[start_x][start_y].color = 1
    if orient == 0 then
      board[start_x + 1][start_y].color = 1
    else
      board[start_x][start_y + 1].color = 1
    end

    -- 2. Place the remaining dominoes
    for d = 2, NUM_DOMINOES do
      local possible_placements = {}
      for x=1, GRID_W do
        for y=1, GRID_H do
          if board[x][y].color == 0 then
            -- Check for horizontal placement
            if is_valid_pos(x+1, y) and board[x+1][y].color == 0 then
              if is_adjacent_to_board(x, y, board) or is_adjacent_to_board(x+1, y, board) then
                add(possible_placements, {x=x, y=y, orient=0})
              end
            end
            -- Check for vertical placement
            if is_valid_pos(x, y+1) and board[x][y+1].color == 0 then
              if is_adjacent_to_board(x, y, board) or is_adjacent_to_board(x, y+1, board) then
                add(possible_placements, {x=x, y=y, orient=1})
              end
            end
          end
        end
      end
      if #possible_placements == 0 then
        goto continue_generation_attempt
      end
      local chosen_placement = possible_placements[flr(rnd(#possible_placements)) + 1]
      board[chosen_placement.x][chosen_placement.y].color = d
      if chosen_placement.orient == 0 then
        board[chosen_placement.x+1][chosen_placement.y].color = d
      else
        board[chosen_placement.x][chosen_placement.y+1].color = d
      end
    end
    success = true
    break
    ::continue_generation_attempt::
  end
  if not success then
    print("board gen failed")
  end
end

function is_valid_pos(x, y)
  return x >= 1 and x <= GRID_W and y >= 1 and y <= GRID_H
end

function is_adjacent_to_board(x, y, board)
  if is_valid_pos(x-1, y) and board[x-1][y].color > 0 then return true end
  if is_valid_pos(x+1, y) and board[x+1][y].color > 0 then return true end
  if is_valid_pos(x, y-1) and board[x][y-1].color > 0 then return true end
  if is_valid_pos(x, y+1) and board[x][y+1].color > 0 then return true end
  return false
end