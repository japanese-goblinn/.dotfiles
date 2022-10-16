OK    := \033[32m
ERR   := \033[31m
RESET := \033[0m

.PHONY: install
install: 
	@./shell/install_dotfiles.sh

.PHONY: export_vscode_extensions
export_vscode_extensions:
	@code --list-extensions > ~/.dotfiles/config/vscode/extensions.txt
	@echo "$(OK)Extensions exported!$(RESET)"