-- Resources:
-- https://arunanshub.hashnode.dev/making-a-proper-initlua-for-real-this-time#heading-the-entire-config
-- https://github.com/LunarVim/nvim-basic-ide/tree/rust-ide-0.7
-- https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-3d0f782f034e

--------------------------------------------------------------------------------
-- Packer bootstrap

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  --print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[
augroup Packer
  autocmd!
  autocmd BufWritePost init.lua PackerCompile
augroup end
]]

--------------------------------------------------------------------------------
--- Keys

local key = vim.keymap.set

-- { noremap = true, expr = true, silent = true })
local opts = { noremap = true, silent = true }
local topts = { silent = true }
vim.g.mapleader = " "

key('',  '<Space>',      '<Nop>',                     opts) -- Disable <Space>
--key("n", '<C-c>',        ':qa!<CR>',                  opts) -- Temp
--key("n", 'q',            ':qa!<CR>',                  opts) -- Temp
key('n', '<C-e>',        '<c-^>',                     opts) -- Switch to last buffer
key('n', '<C-s>',        ':update<CR>',               opts) -- Save current buffer
key('i', '<C-s>',        '<Esc>:update<CR>',          opts) -- Save current buffer
key('n', '<C-S-s>',      ':wa<CR>',                   opts) -- Save all buffers
key('i', '<C-S-s>',      '<Esc>:wa<CR>',              opts) -- Save all buffers
key('n', '<C-M-s>',      ':w !sudo tee %<CR>',        opts) -- sudo Save current buffer
key('n', '<C-x>',        ':bd<cr>',                   { desc = 'Close buffer'      })
key('v', '<',            '<gv',                       opts) -- Reselect visual selection
key('v', '>',            '>gv',                       opts) --  ..after indenting
key('n', 'j',            'gj',                        opts) -- Navigate virtual lines included
key('n', 'k',            'gk',                        opts) -- Navigate virtual lines included
key('i', 'jk',           '<Esc>',                     opts) -- jk->Esc (insert)
key('t', 'jk',           '<C-\\><C-n>',              topts) -- jk->Esc (term)
key('n', '<F5>',         ':luafile $MYVIMRC<CR>',     { desc = 'Reload conf'       })
key('n', '<F6>',         ':luafile $MYVIMRC<CR>:PackerSync<CR>', { desc = 'Reload conf & check plugins' })
key('n', '<Leader><F5>', ':luafile $MYVIMRC<CR>',     { desc = 'Reload config'     })
key('n', '<Leader>f',    ':Telescope find_files<CR>', { desc = 'Find files'        })
key('n', '<Leader>b',    ':Telescope buffers<CR>',    { desc = 'Find buffer'       })
key('n', '<Leader>m',    ':Telescope vim-bookmarks all<CR>', { desc = 'Bookmarks'        })
key('n', '<Leader>r',    ':Telescope live_grep<CR>',  { desc = 'Grep in files'     })
key('v', '<Leader>r',    ':<C-U>Telescope grep_string<CR>',{ desc = 'Grep string in files' })
key('n', '<Leader>g',    ':Neogit<CR>',               { desc = 'Git UI NeoGit'     })
key('n', '<Leader>GG',   ':vertical Git<CR>',         { desc = 'Git UI Fugitive'   })
key('n', '<Leader>GB',   ':Git blame<CR>',            { desc = 'Git blame'         })
key('n', '<Leader>ws',   ':split<cr>',                { desc = 'H split window'    })
key('n', '<Leader>wv',   ':vsplit<cr>',               { desc = 'V split window'    })
key('n', '<Leader>wd',   ':close<cr>',                { desc = 'Close window'      })
key('n', '<Leader>tt',   ':set wrap!<cr>',            { desc = 'Toggle wrap'       })
key('n', '<Leader>qq',   ':qa<CR>',                   { desc = 'Quit all'          })
key('n', '<Leader>qw',   ':wqa<CR>',                  { desc = 'Save and Quit all' })
key('n', '<Leader>\'',   ':Telescope marks<CR>',      { desc = 'Find marks'     })
key('n', '<Leader>"',    ':Telescope registers<CR>',  { desc = 'Find registers'     })
key('n', '<Leader>s',    ':Telescope lsp_document_symbols<CR>',  { desc = 'Find LSP symbols (document)'     })
key('n', '<Leader>S',    ':Telescope lsp_workspace_symbols<CR>', { desc = 'Find LSP symbols (workspace)'     })
--key('n', '<Leader>m',    ':SimplenoteList<CR>', { desc = 'Notes'        })
key('n', '<Leader>n',    ':NvimTreeToggle<CR>', { desc = 'Notes'        })

key('n', '<F1>',         ':colorscheme zenburn<CR>', opts)
key('n', '<F2>',         ':colorscheme dracula<CR>', opts)

key('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
--key('n', '<leader>x', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

--------------------------------------------------------------------------------
--- Settings
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1
vim.opt.clipboard = "unnamedplus"   -- Use system clipboard
vim.opt.relativenumber = true       -- Show relative line numbers
vim.opt.number = true               -- ..AND show curr line number
vim.opt.ignorecase = true           -- Case insensitive searching
vim.opt.smartcase = true            -- ..UNLESS /C or capital in search
vim.opt.cursorline = true           -- Highlight the current line
vim.opt.wrap = false                -- Do not break lines
vim.opt.scrolloff = 4               -- Lines to keep above and below the cursor
vim.opt.sidescrolloff = 4           -- Columns to keep to the left/right of the cursor (wrap=false)
vim.opt.iskeyword:append("-")       -- Treats words with `-` as single words
vim.opt.undofile = true             -- Enable persistent undo
vim.opt.expandtab = true            -- Transform a Tab character to spaces
vim.opt.smartindent = true          -- Make indenting smarter again
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"          -- ? always show the sign column, otherwise it would shift the text each time
vim.opt.autowriteall = true           -- ??? enable autowriteall
-- vim.opt.backup = false           -- Disable backup file
-- vim.opt.termguicolors = true     -- Enable 24-bit RGB colors
vim.opt.list = true                 -- Enable show tab chracters
vim.opt.listchars = 'tab:>-'        -- ..Show tab chracters //→
--------------------------------------------------------------------------------
--- Plugins

require("packer").startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { "phha/zenburn.nvim" }
  use { 'Mofiqul/dracula.nvim' }                   -- Theme: Dracula
  use { 'xiyaowong/nvim-transparent' }

  use { 'preservim/nerdcommenter' }                -- Comments
  use { 'farmergreg/vim-lastplace' }               -- Remember place after reopen
  use { 'nvim-lualine/lualine.nvim',               -- Status line
    requires = { 'kyazdani42/nvim-web-devicons',
                 'arkav/lualine-lsp-progress' }}
  use { 'folke/which-key.nvim' }                   -- Key help popup
  use { "tpope/vim-fugitive" }                     -- Git UI
  use { 'lewis6991/gitsigns.nvim' }                -- Git Sign
  use { 'wsdjeg/vim-fetch' }                       -- Enables to open filepath:100:1

  use { "nvim-telescope/telescope.nvim", requires = {
        'nvim-lua/plenary.nvim' }}

  use { 'tom-anders/telescope-vim-bookmarks.nvim' }
  use { 'crusj/bookmarks.nvim', branch = 'main',
        requires = { 'kyazdani42/nvim-web-devicons' }}

  use { 'TimUntersberger/neogit', requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim' }}


  --use { 'petertriho/nvim-scrollbar', requires = {
        --'kevinhwang91/nvim-hlslens',              -- better glance at matched information, seamlessly jump between matched instances
        --'lewis6991/gitsigns.nvim' }}

  use { 'kdheepak/tabline.nvim',
    config = function()
      vim.cmd[[
        set sessionoptions+=tabpages,globals " store tabpages and globals in session
      ]]
    end,
    requires = { { 'hoob3rt/lualine.nvim', opt=true }, {'kyazdani42/nvim-web-devicons', opt = true} }
  }

  --use 'simplenote-vim/simplenote.vim'

  use 'tpope/vim-vinegar'

  --use { 'nvim-tree/nvim-tree.lua',
    --requires = { 'nvim-tree/nvim-web-devicons' }, -- optional, for file icons
    ----tag = 'nightly' -- optional, updated every week. (see issue #1193)
  --}

  -- LSP Client
  use 'neovim/nvim-lspconfig'

  -- Language Server installer
  use {
    "williamboman/nvim-lsp-installer",
    "neovim/nvim-lspconfig",
  }

  -- BONUS: Customizations over LSP
  -- Show VSCode-esque pictograms
  use 'onsails/lspkind-nvim'
  -- show various elements of LSP as UI
  use {'tami5/lspsaga.nvim', requires = {'neovim/nvim-lspconfig'}}

  -- Autocompletion plugin
  use { 'hrsh7th/nvim-cmp', requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline', } }

  -- snippets
  use { 'hrsh7th/cmp-vsnip', requires = {
        'hrsh7th/vim-vsnip',
        'rafamadriz/friendly-snippets', } }

  -- bracket autocompletion
  --use 'vim-scripts/auto-pairs-gentle'

  -- Fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'


  use { "christoomey/vim-tmux-navigator" }         -- TMUX integration


  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

--------------------------------------------------------------------------------
--- Plugin settings

--local ok, p = pcall(require, 'zenburn')
--if ok then
  --p.setup()
  ----vim.cmd('colorscheme zenburn')
  ----require("transparent").setup({ enable = true })
--end


local ok, p = pcall(require, 'dracula')
if ok then
  p.setup({
    colors = {
      selection = '#222222',
      visual = '#9900FF',
      --visual = '#000044',
      --menu = '#FFFF00',
    },
    transparent_bg = true
  })
  vim.cmd('colorscheme dracula')
end

local ok, p = pcall(require, 'lualine')
if ok then
  vim.o.showmode = false  -- we don't need to see things like -- INSERT -- anymore
  p.setup {
    options = {
      globalstatus = true,
      icons_enabled = true,
      theme = "auto",
      --theme = "zenburn",
      section_separators = { left = '', right = '' },
      component_separators = { left = '', right = '' },
      disabled_filetypes = { 'alpha', 'dashboard' },
      always_divide_middle = false,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          file_status = true,      -- Displays file status (readonly status, modified status)
          newfile_status = false,  -- Display new file status (new file means no write after created)
          path = 1,                -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory

          shorting_target = 40,    -- Shortens path to leave 40 spaces in the window
          -- for other components. (terrible name, any suggestions?)
          symbols = {
            modified = '[+]',      -- Text to show when the file is modified.
            readonly = '[-]',      -- Text to show when the file is non-modifiable or readonly.
            unnamed = '[No Name]', -- Text to show for unnamed buffers.
            newfile = '[New]',     -- Text to show for new created file before first writting
          }
        }
      },
      lualine_x = {'encoding', 'fileformat', 'filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'}
    }
    --sections = {
    --lualine_a = { "mode" },
    --lualine_b = { "branch" },
    --lualine_c = { diagnostics },
    --lualine_x = { diff, spaces, "encoding", filetype },
    --lualine_y = { "location" },
    --lualine_z = { "progress" },
    --},
  }
end

local ok, p = pcall(require, "which-key")
if ok then
  p.setup()
end

--local ok, p = pcall(require, "cmp")
--if ok then
  --p.setup()
--end

local ok, p = pcall(require, "bookmarks")
if ok then
  p.setup()
end

local ok, p = pcall(require, "telescope")
if ok then
  p.setup()
  --p.setup({
    --extensions = {
      --fzf = {
        --fuzzy = true,
        --override_generic_sorter = false,
        --override_file_sorter = true,
        --case_mode = "smart_case"
      --},
      --media_files = {
        --filetypes = {"png", "webp", "jpg", "jpeg"},
        --find_cmd = "rg"
      --},
      --file_browser = {
        --theme = "ivy"
      --},
      --bookmarks = {
        --selected_browser = "brave",
        --url_open_plugin = "open_browser"
      --}
    --}
  --})

  p.load_extension('vim_bookmarks')
end


--- fugitive
--local ok, p = pcall(require, "vim-fugitive")
--if ok then
 -- vim.api.nvim_set_keymap('n', '<Leader>gh', ':diffget //3<cr>', {noremap = true})
 -- vim.api.nvim_set_keymap('n', '<Leader>gu', ':diffget //2<cr>', {noremap = true})
--end

local ok, p = pcall(require, "gitsigns")
if ok then
  p.setup()
end

local ok, p = pcall(require, "hlslens")
if ok then
  p.setup()
end

--local ok, p = pcall(require, "scrollbar")
--if ok then
  --p.setup()
--end

--local codewindow = require('codewindow')
--codewindow.setup()
--codewindow.apply_default_keybinds()

local ok, p =   pcall(require, "neogit")
if ok then
  p.setup { integrations = { diffview = true } }
end
  
local ok, p = pcall(require, "tabline")
if ok then
  p.setup {
    enable = true,
    options = {
      -- If lualine is installed tabline will use separators configured in lualine by default.
      -- These options can be used to override those settings.
      --section_separators = {'', ''},
      --component_separators = {'', ''},
      --max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
      show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
      --show_devicons = true, -- this shows devicons in buffer section
      show_devicons = false, -- this shows devicons in buffer section
      --show_bufnr = false, -- this appends [bufnr] to buffer section,
      show_filename_only = true, ---- shows base filename only instead of relative path in filename
      --modified_icon = "+ ", -- change the default modified icon
      --modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
      --show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
    }
  }
end


require('lspconfig')

local lsp_installer = require("nvim-lsp-installer")

-- The required servers
local servers = {
  "rust_analyzer",
  "bashls",
  "gopls",
  --"pyright",
  "pylsp",
  --"sumneko_lua",
  "html",
  "clangd",
  "vimls",
  "emmet_ls",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end


local on_attach = function(_, bufnr)

  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bopts = { noremap=true, silent=true, buffer=bufnr }
  key('n', 'K', vim.lsp.buf.hover, bopts)
  --buf_set_keymap('n', 'K', "<cmd>lua require('lspsaga.hover').render_hover_doc()<CR>", bopts)

  -- jump to definition
  --buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', bopts)
  key('n', 'gd', vim.lsp.buf.definition, bopts)
  key('n', 'gD', vim.lsp.buf.declaration, bopts)
  --key('n', 'gi', vim.lsp.buf.implementation, bopts)
  key('n', 'gt', vim.lsp.buf.type_definition, bopts)
  key('n', 'gr', ':Lspsaga lsp_finder<CR>', bopts) -- vim.lsp.buf.references

  key('n', '<leader>ll', vim.diagnostic.open_float, bopts)
  key('n', '<leader>ls', ':Lspsaga signature_help<CR>', bopts)
  key('n', '<leader>ld', ':Lspsaga hover_doc<CR>', bopts)
  key('n', '<leader>lp', ':Lspsaga preview_definition<CR>', bopts)
  key('n', '<leader>lr', ':Lspsaga rename<CR>', bopts)
  key('n', '<leader>la', ':Lspsaga code_action<CR>', bopts)
  key('v', '<leader>la', ":<C-U>Lspsaga range_code_action()<CR>", bopts)
  --key('n', '<leader>la', ":lua require('lspsaga.codeaction').code_action()<CR>", bopts)
  --key('v', '<leader>la', ":<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>", bopts)
  --key('n', '<leader>lf', vim.lsp.buf.format(), bopts)
  key('n', '<leader>lf', ':lua vim.lsp.buf.format()<CR>', bopts)

  key('n', '<C-p>', ':Lspsaga diagnostic_jump_prev<CR>', bopts)
  key('n', '<C-n>', ':Lspsaga diagnostic_jump_next<CR>', bopts)

  -- Doc popup scrolling
  key('n', '<C-f>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>", bopts)
  key('n', '<C-b>', "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>", bopts)

  -- Floating terminal
  -- NOTE: Use `vim.cmd` since `buf_set_keymap` is not working with `tnoremap...`
  vim.cmd [[
    nnoremap <silent> <A-d> <cmd>lua require('lspsaga.floaterm').open_float_terminal()<CR>
    tnoremap <silent> <A-d> <C-\><C-n>:lua require('lspsaga.floaterm').close_float_terminal()<CR>
  ]]
end



local server_specific_opts = {
  --sumneko_lua = function(opts)
    --opts.settings = {
      --Lua = {
        ---- NOTE: This is required for expansion of lua function signatures!
        --completion = {callSnippet = "Replace"},
        --diagnostics = {
          --globals = {'vim'},
        --},
      --},
    --}
  --end,

  html = function(opts)
    opts.filetypes = {"html", "htmldjango"}
  end,
}



---- `nvim-cmp` comes with additional capabilities, alongside the ones
---- provided by Neovim!
--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

lsp_installer.on_server_ready(function(server)
  -- the keymaps, flags and capabilities that will be sent to the server as
  -- options.
  local opts = {
    on_attach = on_attach,
    flags = {debounce_text_changes = 150},
    --capabilities = capabilities,
  }

  -- If the current surver's name matches with the ones specified in the
  -- `server_specific_opts`, set the options.
  if server_specific_opts[server.name] then
    server_specific_opts[server.name](opts)
  end
  -- And set up the server with our configuration!
  server:setup(opts)



  -- FIXME
  vim.diagnostic.config({
    virtual_text = false, -- Disable inline diagnostic
    --severity_sort = true, --? makes list inconsistent with Tab
    --pos = 'number',
  })

  --vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      --vim.lsp.diagnostic.on_publish_diagnostics, {
          --virtual_text = false
      --}
  --)

end)

--local lspkind = require('lspkind')
local cmp = require("cmp")

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end


local cmp_kinds = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "ﰠ",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "塞",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}


cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  -- ...
  --formatting = {
    --format = lspkind.cmp_format({
      --with_text = true,
      --preset = 'codicons',
      --symbol_map = cmp_kinds, -- The glyphs will be used by `lspkind`
      --menu = ({
        --buffer = "[Buffer]",
        --nvim_lsp = "[LSP]",
        --luasnip = "[LuaSnip]",
        --nvim_lua = "[Lua]",
        --latex_symbols = "[Latex]",
      --}),
    --}),
  --},

  window = {
    --completion = cmp.config.window.bordered(),
    --documentation = cmp.config.window.bordered(),
  },
  mapping = {
    ['<up>'] = cmp.mapping.select_prev_item(),
    ['<down>'] = cmp.mapping.select_next_item(),
    --['<C-d>'] = cmp.mapping.scroll_docs(-4),
    --['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },

    -- Use Tab and Shift-Tab to browse through the suggestions.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' },
  },
})
-- ...
--
  -- Use buffer source for `/`
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

vim.g.AutoPairs = nil
--vim.g.AutoPairs = {
--  ['(']=')',
--  ['[']=']',
--  ['{']='}',
--  ["'"]="'",
--  ['"']='"',
--  ['`']='`',
--  ['<']='>',
--}

require('nvim-treesitter.configs').setup {
  ensure_installed = {"python", "rust", "c", "cpp", "bash", "go", "html", "nix", "markdown", "lua", "bash", "fish"},
  highlight = {
    enable = true, -- false will disable the whole extension
  },
}


require("lspsaga").init_lsp_saga({
  finder_action_keys = {
    open = '<CR>',
    quit = {'q', '<esc>'},
  },
  code_action_keys = {
    quit = {'q', '<esc>'},
  },
  rename_action_keys = {
    quit = '<esc>',
  },
})


--require("nvim-tree").setup {
  --update_focused_file = {
    --enable = true,
    --update_cwd = true,
  --},
  --renderer = {
    --root_folder_modifier = ":t",
    --icons = {
      --glyphs = {
        --default = "",
        --symlink = "",
        --folder = {
          --arrow_open = "",
          --arrow_closed = "",
          --default = "",
          --open = "",
          --empty = "",
          --empty_open = "",
          --symlink = "",
          --symlink_open = "",
        --},
        --git = {
          --unstaged = "",
          --staged = "S",
          --unmerged = "",
          --renamed = "➜",
          --untracked = "U",
          --deleted = "",
          --ignored = "◌",
        --},
      --},
    --},
  --},
  --diagnostics = {
    --enable = true,
    --show_on_dirs = true,
    --icons = {
      --hint = "",
      --info = "",
      --warning = "",
      --error = "",
    --},
  --},
  --view = {
    --width = 30,
    --side = "left",
    --mappings = {
      --list = {
        ----{ key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
        ----{ key = "h", cb = tree_cb "close_node" },
        ----{ key = "v", cb = tree_cb "vsplit" },
      --},
    --},
  --},
--}

--vim.api.nvim_exec([[
  --source ~/.simplenoterc
--]], true)


vim.api.nvim_exec([[
  augroup FugitiveMappings
    autocmd!
    autocmd FileType fugitive nmap <buffer> <Tab> =
    autocmd FileType fugitive nmap <buffer> q :q<cr>
  augroup
]], true)

