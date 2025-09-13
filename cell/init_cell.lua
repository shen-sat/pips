function init_cell(x, y, color, value)
  local cell = {
    x = x,
    y = y,
    value = value,
    color = color or 0,
    draw = function(self)
      if self.color and self.color > 0 then
        local color_index = self.color
        local color = DOMINO_COLORS[color_index]
        local cell_x = self.x
        local cell_y = self.y
        local cell_x2 = cell_x + CELL_SIZE - 1
        local cell_y2 = cell_y + CELL_SIZE - 1
        local seg = 4 -- segment length
        local gap = 4 -- gap length
        -- Top edge
        for i=0, CELL_SIZE-1, seg+gap do
          line(cell_x+i, cell_y, min(cell_x+i+seg-1, cell_x2), cell_y, color)
        end
        -- Bottom edge
        for i=0, CELL_SIZE-1, seg+gap do
          line(cell_x+i, cell_y2, min(cell_x+i+seg-1, cell_x2), cell_y2, color)
        end
        -- Left edge
        for i=0, CELL_SIZE-1, seg+gap do
          line(cell_x, cell_y+i, cell_x, min(cell_y+i+seg-1, cell_y2), color)
        end
        -- Right edge
        for i=0, CELL_SIZE-1, seg+gap do
          line(cell_x2, cell_y+i, cell_x2, min(cell_y+i+seg-1, cell_y2), color)
        end
        -- draw value
        print(self.value, self.x + 4, self.y + 4, 7)
      end
    end
  }
  return cell
end
