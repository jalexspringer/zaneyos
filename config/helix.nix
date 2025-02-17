{ pkgs, inputs, ... }:

{
  programs = {
    helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor = {
          bufferline = "multiple";
          color-modes = true;
          line-number = "relative";
          mouse = false;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          file-picker.hidden = false;

          statusline = {
            mode.normal = "NORMAL";
            mode.insert = "INSERT";
            mode.select = "SELECT";
            left = ["mode" "spinner" "version-control" "separator" "file-name" "file-modification-indicator" "read-only-indicator"];
          };

          auto-save.focus-lost = true;

          lsp = {
            auto-signature-help = false;
            display-messages = true;
          };

          indent-guides = {
            character = "╎";
            render = true;
          };

          end-of-line-diagnostics = "hint";

          inline-diagnostics = {
            cursor-line = "error";
            other-lines = "disable";
          };
        };

        keys = {
          select = {
            "{" = "goto_prev_paragraph";
            "}" = "goto_next_paragraph";
            "A-x" = "extend_to_line_bounds";
            "X" = "select_line_above";
            tab = "extend_parent_node_end";
            "S-tab" = "extend_parent_node_start";
          };
          normal = {
            "A-x" = "extend_to_line_bounds";
            "X" = "select_line_above";
            tab = "move_parent_node_end";
            "S-tab" = "move_parent_node_start";
            space = {
              space = "file_picker";
              e = ":write";
              z = ":sh zig build";
              q = ":write-quit";
            };
          };
          insert = {
            "S-tab" = "move_parent_node_start";
          };
        };
      };

      languages = {
        language = [
          {
            name = "nix";
            auto-format = true;
            formatter = {
              command = "nixfmt";
            };
          }
          {
            name = "python";
            auto-format = true;
            formatter = {
              command = "ruff";
              args = ["format" "-" ];
            };
            language-servers = [
              { name = "pyright"; }
              { name = "ruff-lsp"; }
            ];
            roots = ["uv.lock" ".git" "pyproject.toml"];
            file-types = ["py" "ipynb"];
          }
          # {
          #   name = "markdown";
          #   auto-format = true;
          #   formatter = {
          #     command = "dprint"
          #   }
          # }
        ];

        "language-server".pyright = {
          command = "pyright-langserver";
          args = ["--stdio"];
          config = {};
        };

        "language-server"."ruff-lsp" = {
          command = "ruff-lsp";
          args = [];
          config = {};
        };
      };
    };
  };
}
