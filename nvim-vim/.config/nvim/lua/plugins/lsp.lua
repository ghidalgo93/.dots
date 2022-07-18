local M = {}
function M:configure()

	local status_ok, lspconfig = pcall(require, "lspconfig")
	if not status_ok then
		return
	end

    local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

  local standard_on_attatch = function(client)
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
      vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red gui=italic,underline,bold
        hi LspReferenceText cterm=bold ctermbg=red gui=italic,underline,bold
        hi LspReferenceWrite cterm=bold ctermbg=red gui=italic,underline,bold
        augroup lsp_document_highlight
          autocmd! * <buffer>
          autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
      ]], false)
    end

  end

  local on_attach = function(client)
    standard_on_attatch(client)
  end

  -- Use a loop to conveniently both setup defined servers
  -- and map buffer local keybindings when the language server attaches
  local servers = {"pyright", "tsserver", "yamlls"}

  local ts_on_attach = function(client, bufnr)
              local ts_utils = require("nvim-lsp-ts-utils")

              client.resolved_capabilities.document_formatting = false
              client.resolved_capabilities.document_range_formatting = false

               if client.resolved_capabilities.document_formatting then
                vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
              end

              -- defaults
              ts_utils.setup({
                  debug = false,
                  disable_commands = false,
                  enable_import_on_completion = false,

                  -- import all
                  import_all_timeout = 5000, -- ms
                  -- lower numbers = higher priority
                  import_all_priorities = {
                      same_file = 1, -- add to existing import statement
                      local_files = 2, -- git files or files with relative path markers
                      buffer_content = 3, -- loaded buffer content
                      buffers = 4, -- loaded buffer names
                  },
                  import_all_scan_buffers = 100,
                  import_all_select_source = false,

                  -- filter diagnostics
                  filter_out_diagnostics_by_severity = {},
                  filter_out_diagnostics_by_code = {},

                  -- inlay hints
                  auto_inlay_hints = true,
                  inlay_hints_highlight = "Comment",

                  -- update imports on file move
                  update_imports_on_move = false,
                  require_confirmation_on_move = false,
                  watch_dir = nil,
              })

              -- required to fix code action ranges and filter diagnostics ts_utils.setup_client(client)

              -- no default maps, so you may want to define some here
              local opts = { silent = true }
              vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", opts)
              vim.api.nvim_buf_set_keymap(bufnr, "n", "rf", ":TSLspRenameFile<CR>", opts)
              vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
          end

  for _, lsp in ipairs(servers) do
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    capabilities.textDocument.completion.completionItem.resolveSupport = {
      properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
      }
    }
    if lsp == 'tsserver' then
        require("null-ls").setup({
            sources = {
              require("null-ls").builtins.formatting.eslint_d,
              require("null-ls").builtins.diagnostics.eslint_d
              -- require("null-ls").builtins.diagnostics.eslint_d,
              -- require("null-ls").builtins.formatting.prettier,
              -- require("null-ls").builtins.code_actions.eslint_d
            },
              on_attach = function(client)
                if client.resolved_capabilities.document_formatting then
                    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
                end
            end,
        })

      lspconfig.tsserver.setup({
          -- Needed for inlayHints. Merge this table with your settings or copy
          -- it from the source if you want to add your own init_options.
          init_options = require("nvim-lsp-ts-utils").init_options,
          on_attach = ts_on_attach,

      })
    else
      lspconfig[lsp].setup { capabilities = capabilities, on_attach = on_attach }
    end
  end
  -- })

  -- LUA
  -- local system_name = "macOS" -- (Linux, macOS, or Windows)
  -- local sumneko_root_path = '~/.linters/lua-language-server'
  -- local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

  require('lspconfig').sumneko_lua.setup({
    -- cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
    -- An example of settings for an LSP server.
    --    For more options, see nvim-lspconfig
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Setup your lua path
          path = vim.split(package.path, ';'),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      }
    },

    on_attach = on_attach
  })

end

M.configure()
return M
