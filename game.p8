pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
#include shared.lua
#include cell/init_cell.lua
#include cell/init_cells.lua
#include board/init_board.lua
#include domino/init_domino.lua
-- A list of colors to assign to each domino for visualization
DOMINO_COLORS = {
  7,  -- 1: light gray
  11, -- 2: light blue
  10, -- 3: green
  5,  -- 4: red
}

GRID_W = 4
GRID_H = 4
CELL_SIZE = 20
NUM_DOMINOES = #DOMINO_COLORS

function _init()
  local board = init_board(GRID_W, GRID_H, NUM_DOMINOES, DOMINO_COLORS)
  cells = init_cells(board)
end

function _update()
  if btnp(4) then
    board = init_board(GRID_W, GRID_H, NUM_DOMINOES, DOMINO_COLORS)
  end
end

function _draw()
  cls()
  for cell in all(cells) do
    cell:draw()
  end
  print(shift_x, 0, 120, 7)
end