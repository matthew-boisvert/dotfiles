#!/usr/bin/env bash

set -e

# shellcheck source=../scripts/util.sh
source "$(pwd)/scripts/util.sh"

FONTS_DIR="$HOME/.local/share/fonts"

do_install() {
	local packages=(
        bash
		cmake
		fontconfig
		git
		neovim
		python@3.9
		ripgrep
		shellcheck
		tig
		tmux
	)

	info "[system] Install packages"
	brew install "${packages[@]}"
}

do_configure() {
	info "[system] Configure"
	info "[system][configure] Install nerd font"

    brew tap homebrew/cask-fonts
    brew install font-hack-nerd-font
}

main() {
	command=$1
	case $command in
	"install")
		shift
		do_install "$@"
		;;
	"configure")
		shift
		do_configure "$@"
		;;
	*)
		error "$(basename "$0"): '$command' is not a valid command"
		;;
	esac
}

main "$@"
