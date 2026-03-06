return {
  'coder/claudecode.nvim',
  config = function()
    require('claudecode').setup {
      auto_start = true,
      split_side = 'right',
      split_width_percentage = 0.35,
      track_selection = true,
    }

    -- Toggle Claude terminal
    vim.keymap.set('n', '<leader>ac', '<cmd>ClaudeCode<cr>', { desc = '[A]I [C]laude toggle' })
    -- Add current buffer to context
    vim.keymap.set('n', '<leader>aa', '<cmd>ClaudeCodeAdd %<cr>', { desc = '[A]I [A]dd buffer' })
    -- Send visual selection to Claude
    vim.keymap.set('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>', { desc = '[A]I [S]end selection' })
    -- Accept / deny diffs
    vim.keymap.set('n', '<leader>ay', '<cmd>ClaudeCodeDiffAccept<cr>', { desc = '[A]I diff accept [Y]es' })
    vim.keymap.set('n', '<leader>an', '<cmd>ClaudeCodeDiffDeny<cr>', { desc = '[A]I diff de[N]y' })
  end,
}
