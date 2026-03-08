-- Plugin: Modern LSP Configuration for Neovim 0.11+
-- URL: https://github.com/neovim/nvim-lspconfig
--
-- Description:
-- Modern LSP configuration using Neovim 0.11's new vim.lsp.config() and vim.lsp.enable()
-- features for simplified and more performant LSP setup. Optimized for Python, C/C++, 
-- LaTeX, bash, lua, html, javascript, and more.
--
-- Key Improvements:
-- - Uses native Neovim 0.11 LSP configuration
-- - Optimized Python support with minimal pylsp configuration for performance
-- - Optimized settings for performance in large codebases
-- - Enhanced capabilities and error handling

return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools
    { 'williamboman/mason.nvim', config = true },
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    -- Useful status updates for LSP
    { 'j-hui/fidget.nvim', opts = {} },

    -- Enhanced Lua development
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },

    -- Allows extra capabilities provided by nvim-cmp
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    -- Auto-install Python LSP dependencies if missing
    local function ensure_pylsp_dependencies()
      local function is_installed(cmd)
        return vim.fn.executable(cmd) == 1
      end
      
      local function install_pylsp()
        vim.notify("Installing pylsp dependencies...", vim.log.levels.INFO)
        local install_cmd = "python3 -m pip install python-lsp-server[all] pylsp-mypy"
        
        vim.fn.jobstart(install_cmd, {
          on_exit = function(_, exit_code)
            if exit_code == 0 then
              vim.notify("pylsp dependencies installed successfully!", vim.log.levels.INFO)
              vim.schedule(function()
                -- Restart LSP for Python files
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                  if vim.bo[buf].filetype == "python" and vim.api.nvim_buf_is_loaded(buf) then
                    vim.cmd("LspRestart")
                    break
                  end
                end
              end)
            else
              vim.notify("Failed to install pylsp dependencies", vim.log.levels.ERROR)
            end
          end,
          stdout_buffered = true,
          stderr_buffered = true,
        })
      end
      
      -- Check if pylsp is available
      if not is_installed('pylsp') then
        -- Ask user before installing
        vim.ui.select(
          {'Yes', 'No'}, 
          { prompt = 'pylsp not found. Install python-lsp-server[all] and pylsp-mypy?' },
          function(choice)
            if choice == 'Yes' then
              install_pylsp()
            else
              vim.notify("pylsp not installed. Python LSP features will be limited.", vim.log.levels.WARN)
            end
          end
        )
      end
    end

    -- Modern LSP setup using Neovim 0.11 features
    
    -- Enhanced capabilities with cmp integration
    local capabilities = vim.tbl_deep_extend(
      'force',
      vim.lsp.protocol.make_client_capabilities(),
      require('cmp_nvim_lsp').default_capabilities()
    )

    -- Define language server configurations using modern vim.lsp.config
    local servers = {
      -- Python: Full-featured pylsp with ruff handling linting/formatting
      pylsp = {
        settings = {
          pylsp = {
            plugins = {
              -- === MINIMAL JEDI FEATURES ONLY ===
              jedi_completion = { 
                enabled = true,
                include_params = false, -- Disable for performance
                include_class_objects = false, -- Disable for performance
                include_function_objects = false, -- Disable for performance
                fuzzy = false, -- Disable for performance
                eager = false,
                resolve_at_most = 5, -- Very low limit
              },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = false }, -- Disable for performance
              jedi_signature_help = { enabled = true },
              jedi_symbols = { enabled = false }, -- Disable for performance
              jedi_definition = { 
                enabled = true,
                follow_imports = false, -- Disable for performance
                follow_builtin_imports = false,
              },
              
              -- === DISABLE ALL ROPE FEATURES ===
              rope_completion = { enabled = false },
              rope_autoimport = { enabled = false },
              rope_rename = { enabled = false },
              
              -- === DISABLE ALL LINTING/FORMATTING ===
              pyflakes = { enabled = false },
              pycodestyle = { enabled = false },
              mccabe = { enabled = false },
              pydocstyle = { enabled = false },
              pylint = { enabled = false },
              flake8 = { enabled = false },
              yapf = { enabled = false },
              autopep8 = { enabled = false },
              black = { enabled = false },
              isort = { enabled = false },
              
              -- === DISABLE RUFF INTEGRATION ===
              ruff = { enabled = false }, -- Use separate ruff LSP instead
              
              -- === DISABLE ALL ADDITIONAL FEATURES ===
              preload = { enabled = false },
              folding = { enabled = false },
              pylsp_mypy = { enabled = false },
            },
          },
        },
        -- Balanced performance settings
        flags = {
          debounce_text_changes = 150, -- Responsive but not overwhelming
          allow_incremental_sync = true, -- Better performance on large files
        },
        timeout_ms = 10000, -- 10 second timeout
        filetypes = { "python" },
        single_file_support = true,
      },

      -- Ruff LSP for ultra-fast Python linting
      ruff = {
        init_options = {
          settings = {
            args = {
              '--line-length=79',
              '--select=E,W,F,I,N,UP,YTT,ANN,S,BLE,FBT,B,A,COM,DTZ,EM,EXE,FA,ISC,ICN,G,INP,PIE,T20,PYI,PT,Q,RSE,RET,SLF,SLOT,SIM,TID,TCH,INT,ARG,PTH,TD,FIX,ERA,PD,PGH,PL,TRY,FLY,NPY,PERF,FURB,LOG,RUF',
            },
          },
        },
      },

      -- C/C++ - clangd with init_options added back
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=none',
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        -- root_dir removed - was causing "File exists" conflicts
        capabilities = vim.tbl_extend('force', capabilities, {
          offsetEncoding = { 'utf-16' },
        }),
        -- Disable clangd formatting - none-ls handles it with proper .clang-format support
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },

      -- JavaScript/TypeScript
      ts_ls = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'literal',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },

      -- Lua (optimized for Neovim)
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            runtime = { 
              version = 'LuaJIT',
              path = vim.split(package.path, ';'),
            },
            workspace = {
              checkThirdParty = false,
              library = {
                '${3rd}/luv/library',
                unpack(vim.api.nvim_get_runtime_file('', true)),
              },
            },
            diagnostics = { 
              disable = { 'missing-fields' },
              globals = { 'vim' },
            },
            telemetry = { enable = false },
            hint = { enable = true },
          },
        },
      },

      -- Bash/Shell
      bashls = {
        filetypes = { 'sh', 'bash', 'zsh' },
        settings = {
          bashIde = {
            globPattern = '**/*@(.sh|.inc|.bash|.command)',
          },
        },
      },

      -- LaTeX
      texlab = {
        settings = {
          texlab = {
            build = {
              executable = 'latexmk',
              args = { '-pdf', '-interaction=nonstopmode', '-synctex=1', '%f' },
              onSave = false,
            },
            chktex = {
              onOpenAndSave = true,
              onEdit = false,
            },
            diagnosticsDelay = 300,
            latexFormatter = 'latexindent',
            latexindent = {
              ['local'] = nil,
              modifyLineBreaks = false,
            },
          },
        },
      },

      -- HTML
      html = { 
        filetypes = { 'html', 'twig', 'hbs' },
        settings = {
          html = {
            format = {
              templating = true,
              wrapLineLength = 120,
              wrapAttributes = 'auto',
            },
            hover = {
              documentation = true,
              references = true,
            },
          },
        },
      },

      -- CSS
      cssls = {
        settings = {
          css = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
          scss = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
          less = {
            validate = true,
            lint = {
              unknownAtRules = 'ignore',
            },
          },
        },
      },

      -- JSON
      jsonls = {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      },

      -- YAML
      yamlls = {
        settings = {
          yaml = {
            schemaStore = {
              enable = false,
              url = '',
            },
            schemas = require('schemastore').yaml.schemas(),
          },
        },
      },

      -- Additional useful servers
      dockerls = {},
      marksman = {}, -- Markdown
    }

    -- Configure each server using modern Neovim 0.11 syntax
    for server, config in pairs(servers) do
      if config.enabled ~= false then
        -- Set up the server configuration
        vim.lsp.config[server] = vim.tbl_deep_extend('force', {
          capabilities = capabilities,
        }, config)
      end
    end

    -- Set up Mason for tool installation
    require('mason').setup({
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗'
        }
      }
    })

    -- Ensure LSP servers are installed (server names are lspconfig IDs)
    local lsp_ensure_installed = {}
    for server, config in pairs(servers) do
      if config.enabled ~= false then
        table.insert(lsp_ensure_installed, server)
      end
    end

    require('mason-lspconfig').setup({
      ensure_installed = lsp_ensure_installed,
      automatic_installation = false,
    })

    -- Ensure non-LSP tools are installed (mason package names)
    require('mason-tool-installer').setup({
      ensure_installed = {
        'stylua',
        'clang-format',
        'prettier',
        'black',
        'ruff',
        'mypy',
        'shellcheck',
        'shfmt',
        'checkmake',
        'cspell',
      },
      auto_update = false,
      run_on_start = true,
    })

    -- Enhanced keymaps for LSP (set up globally)
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('modern-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { 
            buffer = event.buf, 
            desc = 'LSP: ' .. desc,
            silent = true,
          })
        end

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- Disable clangd formatting to prevent conflicts with conform.nvim
        if client.name == 'clangd' then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end

        -- Navigation
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('gy', require('telescope.builtin').lsp_type_definitions, 'T[y]pe Definition')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Code actions
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Documentation
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('<C-k>', vim.lsp.buf.signature_help, 'Signature Help', 'i')

        -- Symbols
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

        -- Formatting (conform.nvim handles formatter selection; falls back to LSP)
        map('<leader>lf', function()
          local ok, conform = pcall(require, 'conform')
          if ok then
            conform.format({ async = true, lsp_fallback = true })
          else
            vim.lsp.buf.format({ async = true })
          end
        end, '[L]SP [F]ormat')

        -- Inlay hints
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end

        -- Document highlighting
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
          local highlight_augroup = vim.api.nvim_create_augroup('lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds({ group = 'lsp-highlight', buffer = event2.buf })
            end,
          })
        end

        -- Format on save disabled here - none-ls handles it to avoid conflicts
      end,
    })

    -- Auto-enable LSP servers when appropriate files are opened
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('lsp-auto-enable', { clear = true }),
      callback = function(event)
        -- Check for Python LSP dependencies when opening Python files
        if event.match == 'python' then
          ensure_pylsp_dependencies()
        end
        
        local filetype_to_server = {
          python = { 'pylsp', 'ruff' },
          c = { 'clangd' },
          cpp = { 'clangd' },
          javascript = { 'ts_ls' },
          typescript = { 'ts_ls' },
          lua = { 'lua_ls' },
          sh = { 'bashls' },
          bash = { 'bashls' },
          zsh = { 'bashls' },
          tex = { 'texlab' },
          html = { 'html' },
          css = { 'cssls' },
          json = { 'jsonls' },
          yaml = { 'yamlls' },
          dockerfile = { 'dockerls' },
          markdown = { 'marksman' },
        }

        local servers_for_ft = filetype_to_server[event.match]
        if servers_for_ft then
          for _, server in ipairs(servers_for_ft) do
            if vim.lsp.config[server] then
              vim.lsp.enable(server)
            end
          end
        end
      end,
    })
  end,
}
