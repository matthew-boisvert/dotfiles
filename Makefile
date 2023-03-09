include test.mk

.DEFAULT_GOAL := all

all: system languages terminal tools ## Install and configure everything (default)
help: ## Display help
	@grep -hE '^[a-zA-Z_0-9%-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

system: system-install system-configure ## Install and configure
system-install: ## Install system packages
	@./scripts/system.sh install
system-configure: ## Create directories, install fonts, etc.
	@./scripts/system.sh configure

languages: rust node ## Install programming languages
rust: ## Install Rust
	@./scripts/rust.sh install
node: nvm ## Install Node.js
	@./scripts/node.sh install
nvm: ## Install Node version manager
	@./scripts/nvm.sh install

terminal: tmux zsh ohmyzsh fzf ## Setup the terminal
tmux: ## Configure tmux
	@./scripts/tmux.sh configure
zsh: ## Configure zsh
	@./scripts/zsh.sh configure
ohmyzsh: ohmyzsh-install ohmyzsh-configure ## Install and configure Oh My Zsh
ohmyzsh-install: ## Install Oh My Zsh
	@./scripts/ohmyzsh.sh install
ohmyzsh-configure: ## Configure Oh My Zsh
	@./scripts/ohmyzsh.sh configure
fzf: ## Install FZF
	@./scripts/fzf.sh install

tools: bat tig
bat: bat-install ## Install and configure bat
bat-install: ## Install bat
	@./scripts/bat.sh install
tig: ## Configure tig
	@./scripts/tig.sh configure
