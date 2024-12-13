--[[
 _   _ _____ _____     _____ __  __ _ 
| \ | | ____/ _ \ \   / /_ _|  \/  | |
|  \| |  _|| | | \ \ / / | || |\/| | |
| |\  | |__| |_| |\ V /  | || |  | |_|
|_| \_|_____\___/  \_/  |___|_|  |_(_)
                                      
--]]
-- MAKE SURE TO RUN :PackerSync after getting this init.lua
-- Auto-install packer.nvim if not installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installing packer, close and reopen Neovim...")
    vim.cmd([[packadd packer.nvim]])
end

-- Packer setup
local status, packer = pcall(require, 'packer')
if not status then
    return
end

packer.init()

packer.startup(function(use)
    use 'wbthomason/packer.nvim'  -- Manage itself
    use 'nvim-treesitter/nvim-treesitter'  -- Treesitter
	use 'f4z3r/gruvbox-material.nvim' --gruvbox
    use 'nvim-treesitter/playground'  -- Optional Treesitter Playground
	use {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
	requires = { {'nvim-lua/plenary.nvim'} }
	}
    use { "catppuccin/nvim", as = "catppuccin" }  -- Catppuccin theme
	use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
		}
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('nvim-tree').setup {
                view = { width = 20, side = 'left', auto_close = true },
            }
        end,
    }
end)

-- Treesitter configuration
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "cpp", "lua", "python", "javascript" },  -- Add more languages as needed
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

-- Enable true colors
vim.opt.termguicolors = true

-- values shown are defaults and will be used if not provided
require('gruvbox-material').setup({
  italics = false,             -- enable italics in general
  contrast = "medium",        -- set contrast, can be any of "hard", "medium", "soft"
  comments = {
    italics = false,           -- enable italic comments
  },
  background = {
    transparent = false,      -- set the background to transparent
  },
  float = {
    force_background = false, -- force background on floats even when background.transparent is set
    background_color = nil,   -- set color for float backgrounds. If nil, uses the default color set
                              -- by the color scheme
  },
  signs = {
    highlight = true,         -- whether to highlight signs
  },
  customize = nil,            -- customize the theme in any way you desire, see below what this
                              -- configuration accepts
})

vim.cmd('colorscheme gruvbox-material')
-- Set custom highlight for variables and other syntax elements
--vim.api.nvim_set_hl(0, '@variable', { fg = '#f87262' })
--vim.api.nvim_set_hl(0, '@punctuation.bracket', { fg = '#FFC34D' })
--vim.api.nvim_set_hl(0, '@function.builtin', { fg = '#ff9083' })
--vim.api.nvim_set_hl(0, '@operator', { fg = '#f5a97f' })
--vim.api.nvim_set_hl(0, '@function.macro', { fg = '#75baff' })
--vim.api.nvim_set_hl(0, '@punctuation.delimiter', { fg = '#FFB84E' })
--vim.api.nvim_set_hl(0, '@comment', { fg = '#6e738d' })

-- Line numbers
vim.wo.number = true

-- Tab and indentation settings
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.wrap = false

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
