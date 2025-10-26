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
-- - Better Python support with basedpyright instead of pylsp for large repos
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
              -- === CORE JEDI FEATURES (pylsp's strength) ===
              jedi_completion = { 
                enabled = true,
                include_params = true,
                include_class_objects = true, -- Enable for full completions
                include_function_objects = true,
                fuzzy = true,
                eager = false, -- Don't preload all modules
                resolve_at_most = 25, -- Limit for performance
                cache_for = {"pandas", "numpy", "matplotlib"}, -- Cache common libraries
              },
              jedi_hover = { enabled = true },
              jedi_references = { enabled = true },
              jedi_signature_help = { enabled = true },
              jedi_symbols = { 
                enabled = true,
                all_scopes = true, -- Enable full symbol search
                include_import_symbols = true,
              },
              jedi_definition = { 
                enabled = true,
                follow_imports = true,
                follow_builtin_imports = true,
              },
              
              -- === ROPE FEATURES (refactoring) ===
              rope_completion = { 
                enabled = true,
                eager = false, -- Only when needed
              },
              rope_autoimport = { 
                enabled = true,
                completions = { enabled = true },
                code_actions = { enabled = true },
              },
              rope_rename = { enabled = true },
              
              -- === DISABLE LINTING/FORMATTING (ruff handles these) ===
              pyflakes = { enabled = false }, -- ruff does this better
              pycodestyle = { enabled = false }, -- ruff does this better
              mccabe = { enabled = false }, -- ruff does this better
              pydocstyle = { enabled = false }, -- ruff does this better
              pylint = { enabled = false }, -- ruff does this better
              flake8 = { enabled = false }, -- ruff does this better
              
              yapf = { enabled = false }, -- ruff does this better
              autopep8 = { enabled = false }, -- ruff does this better
              black = { enabled = false }, -- ruff does this better
              isort = { enabled = false }, -- ruff does this better
              
              -- === RUFF INTEGRATION ===
              ruff = { 
                enabled = true,
                formatEnabled = true,
                lineLength = 79,
                config = '~/.config/nvim/ruff.toml',
                cache = true,
                preview = false,
              },
              
              -- === ADDITIONAL PYLSP FEATURES ===
              preload = {
                enabled = true,
                modules = {"numpy", "pandas", "matplotlib", "scipy", "astropy"},
              },
              folding = { enabled = true },
              
              -- === MYPY INTEGRATION ===
              pylsp_mypy = { 
                enabled = true,
                live_mode = true,
                strict = false,
                overrides = {"--ignore-missing-imports", true},
                dmypy = true, -- Use daemon for faster checking
              },
            },
          },
        },
        -- Remove performance restrictions for full features
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

      -- C/C++
      clangd = {
        cmd = {
          'clangd',
          '--background-index',
          '--clang-tidy',
          '--header-insertion=iwyu',
          '--completion-style=detailed',
          '--function-arg-placeholders',
          '--fallback-style=Google', -- Match SWIFT config
        },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cuda' },
        root_dir = function(fname)
          return vim.fs.dirname(vim.fs.find({
            'Makefile',
            'configure.ac',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson_options.txt',
            'build.ninja',
            'compile_commands.json',
            '.clangd',
          }, { upward = true, path = fname })[1])
        end,
        capabilities = vim.tbl_extend('force', capabilities, {
          offsetEncoding = { 'utf-16' },
        }),
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

    -- Ensure servers are installed
    local ensure_installed = {}
    for server, config in pairs(servers) do
      if config.enabled ~= false then
        table.insert(ensure_installed, server)
      end
    end
    
    -- Add additional tools
    vim.list_extend(ensure_installed, {
      'stylua',        -- Lua formatter
      'clang-format',  -- C/C++ formatter
      'prettier',      -- JS/HTML/CSS formatter
      'black',         -- Python formatter (backup)
      'ruff',          -- Python linter/formatter
      'mypy',          -- Python type checker
      'shellcheck',    -- Shell script linter
      'shfmt',         -- Shell formatter
    })

    require('mason-tool-installer').setup({
      ensure_installed = ensure_installed,
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

        -- Formatting
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
          map('<leader>lf', function()
            vim.lsp.buf.format({ async = true })
          end, '[L]SP [F]ormat')
        end

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
      end,
    })

    -- Auto-enable LSP servers when appropriate files are opened
    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('lsp-auto-enable', { clear = true }),
      callback = function(event)
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