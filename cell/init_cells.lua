function init_cells(board)
  local cells = {}
  local anchor_x, anchor_y = board:get_board_anchor()

  min_x, max_x = nil, nil
  for x=1, GRID_W do
    for y=1, GRID_H do
      if board[x][y] and board[x][y].color and board[x][y].color > 0 then
        min_x = min(min_x or x, x)
        max_x = max(max_x or x, x)
      end
    end
  end

  x_size = max_x - min_x + 1
  shift_x = flr(128/2) - flr(x_size * CELL_SIZE / 2)

  for x=1, GRID_W do
    for y=1, GRID_H do
      local cell_x = ((x - anchor_x) * CELL_SIZE) + shift_x      
      local cell_y = (y - anchor_y) * CELL_SIZE
      
      add(cells, init_cell(cell_x, cell_y, board[x][y].color, flr(rnd(6)) + 1))
    end
  end

  return cells
end