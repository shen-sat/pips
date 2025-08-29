pico-8 cartridge // http://www.pico-8.com
version 36
__lua__

-- A list of colors to assign to each domino for visualization
domino_colors = {
  7,  -- 1: light gray
  11, -- 2: light blue
  10, -- 3: green
  5,  -- 4: red
  12, -- 5
  13  -- 6
}

-- Global variables for the game state
board = {}
GRID_W = 4
GRID_H = 4
NUM_DOMINOES = #domino_colors
MAX_ATTEMPTS = 20 -- Safety net to prevent infinite loops



-- Helper function to check if a coordinate is within the grid boundaries
function is_valid_pos(x, y)
  return x >= 1 and x <= GRID_W and y >= 1 and y <= GRID_H
end

-- Helper function to check if a square is adjacent to the existing board shape
function is_adjacent_to_board(x, y)
  -- check all 4 orthogonal neighbors
  if is_valid_pos(x-1, y) and board[x-1][y] > 0 then return true end
  if is_valid_pos(x+1, y) and board[x+1][y] > 0 then return true end
  if is_valid_pos(x, y-1) and board[x][y-1] > 0 then return true end
  if is_valid_pos(x, y+1) and board[x][y+1] > 0 then return true end
  return false
end

-- The main board generation function
function generate_board()
  local success = false
  for attempt = 1, MAX_ATTEMPTS do
    -- Initialize a fresh, empty board
    for x=1, GRID_W do
      board[x] = {}
      for y=1, GRID_H do
        board[x][y] = 0
      end
    end

    -- 1. Place the first domino randomly
    local start_x, start_y = flr(rnd(GRID_W)) + 1, flr(rnd(GRID_H)) + 1
    local orient = flr(rnd(2)) -- 0 for horizontal, 1 for vertical
    
    -- Ensure the first domino fits within the bounds
    if orient == 0 and start_x == GRID_W then start_x = GRID_W - 1 end
    if orient == 1 and start_y == GRID_H then start_y = GRID_H - 1 end

    board[start_x][start_y] = 1
    if orient == 0 then
      board[start_x + 1][start_y] = 1
    else
      board[start_x][start_y + 1] = 1
    end

    -- 2. Place the remaining dominoes
    for d = 2, NUM_DOMINOES do
      local possible_placements = {}
      
      -- Find all valid placements
      for x=1, GRID_W do
        for y=1, GRID_H do
          if board[x][y] == 0 then -- Check empty squares
            -- Check for horizontal placement
            if is_valid_pos(x+1, y) and board[x+1][y] == 0 then
              if is_adjacent_to_board(x, y) or is_adjacent_to_board(x+1, y) then
                add(possible_placements, {x=x, y=y, orient=0})
              end
            end
            -- Check for vertical placement
            if is_valid_pos(x, y+1) and board[x][y+1] == 0 then
              if is_adjacent_to_board(x, y) or is_adjacent_to_board(x, y+1) then
                add(possible_placements, {x=x, y=y, orient=1})
              end
            end
          end
        end
      end
      
      -- If no valid placements, this board is a dead end. Try again.
      if #possible_placements == 0 then
        goto continue_generation_attempt
      end

      -- Select a random placement from the list of valid, contiguous placements
      local chosen_placement = possible_placements[flr(rnd(#possible_placements)) + 1]

      -- Place the chosen domino
      board[chosen_placement.x][chosen_placement.y] = d
      if chosen_placement.orient == 0 then
        board[chosen_placement.x+1][chosen_placement.y] = d
      else
        board[chosen_placement.x][chosen_placement.y+1] = d
      end
    end

    -- If we get here, the board was successfully generated.
    success = true
    break
    
    ::continue_generation_attempt::
  end
  
  -- If we've exhausted all attempts, handle the failure case
  if not success then
    -- For now, just print a message. You could display a default board here.
    print("board gen failed")
  end
end

-- Pico-8's main initialization function
function _init()
  -- We need to pre-initialize the tables to avoid the nil value error
  for x=1, GRID_W do
    board[x] = {}
  end
  generate_board()
end

-- Pico-8's main update function
function _update()
  -- Check for the Z button press to generate a new board
  if btnp(4) then
    generate_board()
  end
end

-- Pico-8's main draw function
function _draw()
  cls()
  local x_offset = 64 - (GRID_W * 8 / 2)
  local y_offset = 64 - (GRID_H * 8 / 2)
  
  for x=1, GRID_W do
    for y=1, GRID_H do
      if board[x][y] > 0 then
        local color_index = board[x][y]
        local color = domino_colors[color_index]
        rectfill(x_offset + (x-1)*8, y_offset + (y-1)*8, x_offset + x*8 - 1, y_offset + y*8 - 1, color)
        rect(x_offset + (x-1)*8, y_offset + (y-1)*8, x_offset + x*8 - 1, y_offset + y*8 - 1, 0)
      end
    end
  end
end