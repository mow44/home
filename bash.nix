{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      # Opener for lf
      export OPENER=xdg-open

      # Change keyboard layout
      # setxkbmap -option grp:ctrl_shift_toggle us,ru

      # Expand the history size
      export HISTFILESIZE=10000
      export HISTSIZE=500

      # Don't put duplicate lines in the history and do not add lines that start with a space
      export HISTCONTROL=erasedups:ignoredups:ignorespace

      # Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
      shopt -s checkwinsize

      # Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
      shopt -s histappend
      PROMPT_COMMAND='history -a'

      # Allow ctrl-S for history navigation (with ctrl-R)
      stty -ixon

      # Ignore case on auto-completion
      # Note: bind used instead of sticking these in .inputrc
      if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

      # Show auto-completion list automatically, without double tab
      if [[ $iatest > 0 ]]; then bind "set show-all-if-ambiguous On"; fi

      export EDITOR=hx
      export WALK_EDITOR=hx

      function lk {
        cd "$(walk --icons --fuzzy "$@")"
      }

      function ez {
        eza --icons -1 -a
      }

      # Nix-search. All nixos packages by fzf with caching
      function ns {
        nix search nixpkgs ^ --json | nix run nixpkgs#jq -- -r '. | keys[]' | cut -d \. -f 3- | nix run nixpkgs#fzf
      }
    '';
  };
}
