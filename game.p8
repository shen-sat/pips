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
      if board[x][y] and board[x][y] > 0 then
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
  for x=1, GRID_W do
    for y=1, GRID_H do
      if board[x][y] and board[x][y] > 0 then
        local color_index = board[x][y]
        local color = domino_colors[color_index]
          local cell_x = (x-anchor_x)*size
          local cell_y = (y-anchor_y)*size
          local cell_x2 = cell_x + size - 1
          local cell_y2 = cell_y + size - 1
          local seg = 4 -- segment length
          local gap = 4 -- gap length
          -- Top edge
          for i=0, size-1, seg+gap do
            line(cell_x+i, cell_y, min(cell_x+i+seg-1, cell_x2), cell_y, color)
          end
          -- Bottom edge
          for i=0, size-1, seg+gap do
            line(cell_x+i, cell_y2, min(cell_x+i+seg-1, cell_x2), cell_y2, color)
          end
          -- Left edge
          for i=0, size-1, seg+gap do
            line(cell_x, cell_y+i, cell_x, min(cell_y+i+seg-1, cell_y2), color)
          end
          -- Right edge
          for i=0, size-1, seg+gap do
            line(cell_x2, cell_y+i, cell_x2, min(cell_y+i+seg-1, cell_y2), color)
          end
      end
    end
  end
end