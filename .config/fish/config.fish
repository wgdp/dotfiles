if status is-interactive

end


# gcloud
if test -f ~/Downloads/google-cloud-sdk/path.fish.inc
    source ~/Downloads/google-cloud-sdk/path.fish.inc
end

if test -f ~/Downloads/google-cloud-sdk/completion.fish.inc
    source ~/Downloads/google-cloud-sdk/completion.fish.inc
end

# alias
alias d=docker
alias dc=docker-compose
alias gp='git pull'
alias fc='nvim ~/.config/fish/config.fish'
alias lg=lazygit
alias v=nvim
alias g=git

# exa
if command -v exa
  alias e='exa --icons --git'
  alias l=e
  alias ls=e
end

# /usr/local/bin /usr/bin
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/bin $PATH

# homebrew
set -x PATH /opt/homebrew/bin $PATH

# openssl
set -x LDFLAGS "-L/usr/local/opt/openssl/lib"
set -x CPPFLAGS "-I/usr/local/opt/openssl/include"
set -x PATH "/opt/homebrew/opt/openssl@1.1/bin:$PATH"

# pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
set -x PATH $PYENV_ROOT/bin $PATH
pyenv init - | source

# rust
set -x PATH "$HOME/.cargo/bin" $PATH

# start starship!!
starship init fish | source
