alias v="vim"
alias nv="nvim"
alias ld="lazydocker"
alias lg="lazygit"
# CDs with fzf, very useful
alias cz='cd $(fd . --hidden --type d | fzf -m)'
# usually only useful to check permissions/existence of files
alias lz='ls -la $(fd . --hidden --type f | fzf -m)'
# opens dirs with vim/nvim
alias vz='cz && vim .'
alias nvz='cz && nvim .'
