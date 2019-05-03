FROM ubuntu:18.04

MAINTAINER walkerwaqi@outlook.com

ADD go1.12.4.linux-amd64.tar.gz /usr/local

# RUN export http_proxy=http://172.17.0.1:1087 && export https_proxy=http://172.17.0.1:1087;

# apt-get
RUN apt-get update && apt-get install -y \
        apt-utils sudo zsh pkg-config \
        gcc g++ llvm-4.0 clang-4.0 libclang-4.0-dev \
        make automake autoconf autoconf-archive autotools-dev build-essential cmake gdb libtool autogen \
        vim vim-runtime vim-doc vim-scripts ctags git valgrind doxygen graphviz jq less \
        curl wget net-tools inetutils-ping \
        python2.7 python2.7-dev python3 python3-dev ruby \
        libbz2-dev libssl-dev libgmp3-dev libicu-dev zlib1g-dev libusb-1.0-0-dev libcurl4-gnutls-dev

# .profile
RUN sed -i '1a\\nexport TERM=xterm-256color' /root/.profile

# zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN sed -i 's/^ZSH_THEME=".*"$/ZSH_THEME="ys"/' /root/.zshrc
RUN sed -i '/^# export PATH=$HOME\/bin:\/usr\/local\/bin:$PATH$/a\\n[[ -s "$HOME\/.profile" ]] && source "$HOME\/.profile"' /root/.zshrc

# go
RUN sed -i '$a\\nexport PATH=$PATH:\/usr\/local\/go\/bin\nexport GOROOT=\/usr\/local\/go\nexport GOPATH=$HOME\/go\nexport PATH=$PATH:$GOPATH\/bin' /root/.profile

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

CMD ["zsh"]