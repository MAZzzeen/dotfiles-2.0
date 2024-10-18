# Enable Zsh features
autoload -Uz compinit && compinit

# Enable completion
ZSH_COMPDIR="$HOME/.zcompdump" # or wherever you want your completion dump file
export WORDCHARS='*?[]~=&;!#$%^(){}<>'
export HISTFILE="$HOME"/local/state/zsh/history
export GOPATH="$XDG_DATA_HOME"/go

export ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#FZF Settings
export FZF_DEFAULT_COMMAND='find .'
export FZF_DEFAULT_OPTS='--border=rounded --height=30% --color="pointer:blue"'
export FZF_COMPLETION_TRIGGER=''
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# History settings
HISTFILE="$HOME/.config/.zhist"
HISTSIZE=100000
SAVEHIST=100000
setopt append_history
setopt hist_ignore_dups
setopt extended_glob

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/fzf-tab-git/fzf-tab.plugin.zsh
source <(fzf --zsh)

# Auto-cd and other options
setopt autocd
autoload -Uz zsh-autosuggestions
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#d1a4f4' # Customize as needed

# Key bindings
bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^H' backward-kill-word
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Initialize on launch
fastfetch
compinit -d "$HOME"/.cache/zsh/zcompdump-"$ZSH_VERSION"

# Yazi integration
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Shell aliases
alias ls="eza --icons -la"
alias ":q"="exit"
alias yeet="sudo pacman -Rns"
alias vi="nvim"
alias cls="clear && fastfetch"
alias cd="z"

# Starship initialization
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
