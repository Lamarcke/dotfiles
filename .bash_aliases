alias v="vim"
alias nv="nvim"
alias ld="lazydocker"
alias lg="lazygit"
# CDs with fzf, very useful
alias cz='cd $(find . -type d | fzf -m)'
# usually only useful to check permissions/existence of files
alias lz='ls -la $(find . -type f | fzf -m)'
# opens dirs with vim/nvim
alias vz='cz && vim .'
alias nvz='cz && nvim .'
