FROM ubuntu:16.04

MAINTAINER walkerwaqi@outlook.com

ADD go1.11.5.linux-amd64.tar.gz /usr/local

# RUN export http_proxy=http://172.17.0.1:1087 && export https_proxy=http://172.17.0.1:1087;

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
        gcc g++ llvm-4.0 clang-4.0 libclang-4.0-dev \
        make automake autoconf autoconf-archive autotools-dev build-essential cmake gdb libtool autogen valgrind \
        git vim apt-utils sudo zsh pkg-config doxygen graphviz curl wget net-tools inetutils-ping \
        python2.7 python2.7-dev python3 python3-dev ruby \
        libbz2-dev libssl-dev libgmp3-dev libicu-dev zlib1g-dev libusb-1.0-0-dev libcurl4-gnutls-dev

RUN sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN sed -i 's/^ZSH_THEME="robbyrussell"$/ZSH_THEME="ys"/' /root/.zshrc
RUN sed -i '/^# export PATH=$HOME\/bin:\/usr\/local\/bin:$PATH$/a\\n[[ -s "$HOME\/.profile" ]] && source "$HOME\/.profile"' /root/.zshrc
RUN sed -i '$a\\nexport PATH=$PATH:\/usr\/local\/go\/bin\nexport GOROOT=\/usr\/local\/go\nexport GOPATH=$HOME\/go\nexport PATH=$PATH:$GOPATH\/bin' /root/.profile

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /root

CMD ["zsh"]