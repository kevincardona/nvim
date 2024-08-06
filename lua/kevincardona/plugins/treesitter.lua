-- builds syntax tree for better syntax highlighting
return {

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "vimdoc", "javascript", "typescript", "c", "lua", "rust",
          "jsdoc", "bash", "gdscript", "json", "jsonc", "html", "css",
          "yaml", "ruby"
        },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
        auto_install = true,

        indent = {
          enable = true
        },

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on "syntax" being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = { "markdown" },
        },
      })

      local treesitter_parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      treesitter_parser_config.templ = {
        install_info = {
          url = "https://github.com/vrischmann/tree-sitter-templ.git",
          files = { "src/parser.c", "src/scanner.c" },
          branch = "master",
        },
      }

      vim.treesitter.language.register("templ", "templ")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    config = function()
      require("nvim-treesitter.configs").setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- Custom text objects keymaps
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ad"] = "@conditional.outer",
              ["id"] = "@conditional.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["a/"] = "@comment.outer",
              ["i/"] = "@comment.inner",
              ["ar"] = "@return.outer",
              ["ir"] = "@return.inner",
              ["aj"] = "@parameter.outer",
              ["ij"] = "@paraemter.inner",
              ["os"] = "@statement.outer",
              ["is"] = "@statement.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]d"] = "@conditional.outer",
              ["]b"] = "@block.outer",
              ["]/"] = "@comment.outer",
              ["]r"] = "@return.outer",
              ["]j"] = "@parameter.outer",
              ["]s"] = "@statement.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]D"] = "@conditional.outer",
              ["]B"] = "@block.outer",
              ["]/"] = "@comment.outer",
              ["]R"] = "@return.outer",
              ["]J"] = "@parameter.outer",
              ["]S"] = "@statement.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[d"] = "@conditional.outer",
              ["[b"] = "@block.outer",
              ["[/"] = "@comment.outer",
              ["[r"] = "@return.outer",
              ["[j"] = "@parameter.outer",
              ["[s"] = "@statement.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[D"] = "@conditional.outer",
              ["[B"] = "@block.outer",
              ["[?"] = "@comment.outer",
              ["[R"] = "@return.outer",
              ["[J"] = "@parameter.outer",
              ["[S"] = "@statement.outer",
            },
          },
        }
      })
    end
  }
}
