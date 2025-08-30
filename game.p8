pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
#include shared.lua
#include cell/init_cell.lua
#include board/init_board.lua
#include domino/init_domino.lua
-- A list of colors to assign to each domino for visualization
domino_colors = {
  7,  -- 1: light gray
  11, -- 2: light blue
  10, -- 3: green
  5,  -- 4: red
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

function get_board_anchor(board)
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

function _draw()
  cls()
  local size = 20
  local anchor_x, anchor_y = get_board_anchor(board)
  board:draw(anchor_x, anchor_y, size, domino_colors)
end