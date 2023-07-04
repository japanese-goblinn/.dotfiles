OK    := \033[32m
ERR   := \033[31m
RESET := \033[0m

.PHONY: install
install: 
	@./shell/install_dotfiles.sh