{ pkgs, ... }:
{
  xdg.configFile."lf/icons".source = ./data/lf_icons;

  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    extraConfig =
      let
        vidthumb = pkgs.writeShellScriptBin "vt.sh" ''
          if ! [ -f "$1" ]; then
          	exit 1
          fi

          cache="$HOME/.cache/vidthumb"
          index="$cache/index.json"
          movie="$(${pkgs.toybox}/bin/realpath "$1")"

          mkdir -p "$cache"

          if [ -f "$index" ]; then
          	thumbnail="$(${pkgs.jq}/bin/jq -r ". \"$movie\"" <"$index")"
          	if [[ "$thumbnail" != "null" ]]; then
          		if [[ ! -f "$cache/$thumbnail" ]]; then
          			exit 1
          		fi
          		echo "$cache/$thumbnail"
          		exit 0
          	fi
          fi

          thumbnail="$(uuidgen).jpg"

          if ! ${pkgs.ffmpegthumbnailer}/bin/ffmpegthumbnailer -i "$movie" -o "$cache/$thumbnail" -s 0 2>/dev/null; then
          	exit 1
          fi

          if [[ ! -f "$index" ]]; then
          	echo "{\"$movie\": \"$thumbnail\"}" >"$index"
          fi

          json="$(${pkgs.jq}/bin/jq -r --arg "$movie" "$thumbnail" ". + {\"$movie\": \"$thumbnail\"}" <"$index")"
          echo "$json" >"$index"

          echo "$cache/$thumbnail"
        '';

        previewer = pkgs.writeShellScriptBin "pv.sh" ''
          file=$1
          w=$2
          h=$3
          x=$4
          y=$5

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^image ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$file" < /dev/null > /dev/tty
              exit 1
          fi

          if [[ "$( ${pkgs.file}/bin/file -Lb --mime-type "$file")" =~ ^video ]]; then
              ${pkgs.kitty}/bin/kitty +kitten icat --silent --stdin no --transfer-mode file --place "''${w}x''${h}@''${x}x''${y}" "$(${vidthumb}/bin/vt.sh "$file")" < /dev/null > /dev/tty
              exit 1
          fi

          ${pkgs.pistol}/bin/pistol "$file"
        '';
        cleaner = pkgs.writeShellScriptBin "cl.sh" ''
          ${pkgs.kitty}/bin/kitty +kitten icat --clear --stdin no --silent --transfer-mode file < /dev/null > /dev/tty
        '';
      in
      ''
        set cleaner ${cleaner}/bin/cl.sh
        set previewer ${previewer}/bin/pv.sh
      '';
  };
}
