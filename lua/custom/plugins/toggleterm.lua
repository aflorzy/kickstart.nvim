return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = function()
    local toggleterm = require('toggleterm')

    toggleterm.setup({
      open_mapping = [[<c-\>]],
      direction = 'horizontal',
      size = function(term)
        if term.direction == 'horizontal' then
          return math.floor(vim.o.lines * 0.3)
        elseif term.direction == 'vertical' then
          return math.floor(vim.o.columns * 0.4)
        end
      end,
      -- Allow <c-n> to exit terminal mode normally
      insert_mappings = true,
      terminal_mappings = true,
      shade_terminals = false,
      auto_scroll = true,
    })

    -- Navigate between terminal splits and normal windows using <c-hjkl>
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      -- Exit terminal mode
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
      vim.keymap.set('t', '<c-n>', [[<C-\><C-n>]], opts)
      -- Window navigation from terminal mode
      vim.keymap.set('t', '<c-h>', [[<C-\><C-n><C-w>h]], opts)
      vim.keymap.set('t', '<c-j>', [[<C-\><C-n><C-w>j]], opts)
      vim.keymap.set('t', '<c-k>', [[<C-\><C-n><C-w>k]], opts)
      -- <c-l> intentionally not remapped so it clears the terminal normally
      -- Resize panes from terminal mode
      vim.keymap.set('t', '<c-Up>',    [[<C-\><C-n>:resize +2<cr>]], opts)
      vim.keymap.set('t', '<c-Down>',  [[<C-\><C-n>:resize -2<cr>]], opts)
      vim.keymap.set('t', '<c-Left>',  [[<C-\><C-n>:vertical resize -2<cr>]], opts)
      vim.keymap.set('t', '<c-Right>', [[<C-\><C-n>:vertical resize +2<cr>]], opts)
    end

    -- Apply terminal keymaps whenever a toggleterm buffer opens
    vim.api.nvim_create_autocmd('TermOpen', {
      pattern = 'term://*toggleterm#*',
      callback = function()
        _G.set_terminal_keymaps()
      end,
    })

    -- Open a new numbered terminal in a horizontal split: <leader>t1, <leader>t2, ...
    for i = 1, 5 do
      vim.keymap.set('n', '<leader>t' .. i, function()
        local Terminal = require('toggleterm.terminal').Terminal
        local term = Terminal:new({ count = i, direction = 'float', float_opts = { border = 'curved' } })
        term:toggle()
      end, { desc = 'Toggle terminal ' .. i })
    end

    -- Toggle a vertical split terminal
    vim.keymap.set('n', '<leader>tv', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'vertical' })
      term:toggle()
    end, { desc = 'Toggle vertical terminal' })

    -- Toggle a floating terminal (keep the old float style accessible)
    vim.keymap.set('n', '<leader>tf', function()
      local Terminal = require('toggleterm.terminal').Terminal
      local term = Terminal:new({ direction = 'float', float_opts = { border = 'curved' } })
      term:toggle()
    end, { desc = 'Toggle float terminal' })
  end,
}
