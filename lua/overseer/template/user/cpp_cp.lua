return {
  name = "c++ build (cp)",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "g++ -std=c++17 " .. file .. " -fsanitize=address -Ofast -Wall && ./a.out < std.in > std.out" },
      args = { file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
