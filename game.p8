pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
#include shared.lua
#include board/init_board.lua
#include domino/init_domino.lua
-- A list of colors to assign to each domino for visualization
domino_colors = {
  7,  -- 1: light gray
  11, -- 2: light blue
  10, -- 3: green
  5,  -- 4: red
  12, -- 5
  13  -- 6
}

GRID_W = 4
GRID_H = 4
NUM_DOMINOES = #domino_colors

function _init()
  board = init_board(GRID_W, GRID_H, NUM_DOMINOES, domino_colors)
  -- generate_board(board)
end

function _update()
  if btnp(4) then
    board = init_board(GRID_W, GRID_H, NUM_DOMINOES, domino_colors)
  end
end

function _draw()
  cls()
  local x_offset = 64 - (GRID_W * 8 / 2)
  local y_offset = 64 - (GRID_H * 8 / 2)
  for x=1, GRID_W do
    for y=1, GRID_H do
      if board[x][y] and board[x][y] > 0 then
        local color_index = board[x][y]
        local color = domino_colors[color_index]
        rectfill(x_offset + (x-1)*8, y_offset + (y-1)*8, x_offset + x*8 - 1, y_offset + y*8 - 1, color)
        rect(x_offset + (x-1)*8, y_offset + (y-1)*8, x_offset + x*8 - 1, y_offset + y*8 - 1, 0)
      end
    end
  end
end