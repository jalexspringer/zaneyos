{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = [
        "networkmanager"
        "wheel"
        "libvirtd"
        "scanner"
        "lp"
        "docker"
      ];
      shell = pkgs.fish;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        herbstluftwm
        keymapp
        marksman
        lazygit
        gitu
        dprint
        gdb
        # lldb
        taskwarrior3
        taskwarrior-tui
        exercism
        github-desktop
        _1password-cli
        _1password-gui
        brave
        uv
        pyright
        ruff-lsp
        ruff
      ];
    };
  };
}
