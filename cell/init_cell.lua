function init_cell(x, y, color)
  local cell = {
    x = x,
    y = y,
    color = color or 0,
    draw = function(self, anchor_x, anchor_y, size, domino_colors)
      if self.color and self.color > 0 then
        local color_index = self.color
        local color = domino_colors[color_index]
        local cell_x = (self.x - anchor_x) * size
        local cell_y = (self.y - anchor_y) * size
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
  }
  return cell
end
