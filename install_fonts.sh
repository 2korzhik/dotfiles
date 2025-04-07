#!/usr/bin/env bash

declare -a fonts=(
  # BitstreamVeraSansMono
  # CodeNewRoman
  # DroidSansMono
  # FiraCode
  # FiraMono
  # Go-Mono
  # Hack
  # Hermit
    JetBrainsMono
  # Meslo
  # Noto
  # Overpass
  # ProggyClean
  # RobotoMono
  # SourceCodePro
  # SpaceMono
  # Ubuntu
  # UbuntuMono
)

version='latest'
fonts_dir="${HOME}/.local/share/fonts"

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

for font in "${fonts[@]}"; do
    # Проверка: установлен ли шрифт через fontconfig
    if fc-list | grep -i -q "$font"; then
        echo "Font '$font' is already installed, skipping."
        continue
    fi

    zip_file="${font}.zip"
    if [[ -z "$version" || "$version" == "latest" ]]; then
        download_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${zip_file}"
    else
        download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
    fi
    echo "Downloading $download_url"
    wget "$download_url"
    unzip -o "$zip_file" -d "$fonts_dir"
    rm "$zip_file"
done

find "$fonts_dir" -name '*Windows Compatible*' -delete

fc-cache -fv