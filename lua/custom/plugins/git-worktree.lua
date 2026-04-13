return {
  'ThePrimeagen/git-worktree.nvim',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('git-worktree').setup()
    require('telescope').load_extension('git_worktree')

    local wt = require('telescope').extensions.git_worktree

    vim.keymap.set('n', '<leader>gw', wt.git_worktrees, { desc = '[G]it [W]orktree switch' })
    vim.keymap.set('n', '<leader>gW', wt.create_git_worktree, { desc = '[G]it [W]orktree create' })
  end,
}
