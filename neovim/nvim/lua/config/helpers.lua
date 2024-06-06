M = {}

---@param amount integer?
M.resize_right = function(amount)
  if amount == nil then amount = 2 end
  local width = vim.api.nvim_win_get_width(0)
  local at_right_edge = vim.fn.winnr() == vim.fn.winnr "l"

  if at_right_edge then
    width = width - amount
  else
    width = width + amount
  end

  vim.api.nvim_win_set_width(0, width)
end


---@param amount integer?
M.resize_left = function(amount)
  if amount == nil then amount = 2 end
  local width = vim.api.nvim_win_get_width(0)
  local at_right_edge = vim.fn.winnr() == vim.fn.winnr "l"

  if at_right_edge then
    width = width + amount
  else
    width = width - amount
  end

  vim.api.nvim_win_set_width(0, width)
end


---@param amount integer?
M.resize_up = function(amount)
  if amount == nil then amount = 2 end
  local height = vim.api.nvim_win_get_height(0)
  local at_bottom_edge = vim.fn.winnr() == vim.fn.winnr "j"

  if at_bottom_edge then
    height = height + amount
  else
    height = height - amount
  end

  vim.api.nvim_win_set_height(0, height)
end


---@param amount integer?
M.resize_down = function(amount)
  if amount == nil then amount = 2 end
  local height = vim.api.nvim_win_get_height(0)
  local at_bottom_edge = vim.fn.winnr() == vim.fn.winnr "j"
  local at_top_edge = vim.fn.winnr() == vim.fn.winnr "k"

  if at_bottom_edge and at_top_edge then
    return
  end

  if at_bottom_edge then
    height = height - amount
  else
    height = height + amount
  end

  vim.api.nvim_win_set_height(0, height)
end

return M
