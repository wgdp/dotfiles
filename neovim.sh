# !/bin/bash

nvim +PackerInstall +PackerCompile +qall
nvim +LspInstall gopls efm marksman omnisharp pyright rust_analyzer sumneko_lua +qall
nvim +TSInstall \
    c \
    go \
    rust \
    lua \
    ruby \
    python \
    c_sharp \
    bash \
    markdown \
    markdown_inline \
    cpp \
    fish \
    javascript \
    json \
    json5 \
    toml \
    yaml \
    html \
    css \
    scss \
    java \
+qall

