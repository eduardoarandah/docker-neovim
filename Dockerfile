# based on https://github.com/AnatoleLucet/docker-neovim
FROM alpine:3.13 AS builder

ARG BUILD_DEPS="autoconf automake cmake curl g++ gettext gettext-dev git libtool make ninja openssl pkgconfig unzip binutils"
ARG TARGET=stable

RUN apk add --no-cache ${BUILD_DEPS} && \
  git clone https://github.com/neovim/neovim.git /tmp/neovim && \
  cd /tmp/neovim && \
  git fetch --all --tags -f && \
  git checkout ${TARGET} && \
  make CMAKE_BUILD_TYPE=Release && \
  make CMAKE_INSTALL_PREFIX=/usr/local install && \
  strip /usr/local/bin/nvim

# Required shared libraries
FROM alpine:3.13
COPY --from=builder /usr/local /usr/local/
RUN true # see: https://github.com/moby/moby/issues/37965
COPY --from=builder /lib/* /lib/
RUN true
COPY --from=builder /usr/lib/* /usr/lib/

# more dependencies
# g++ c compiler for treesitter
RUN apk add --no-cache g++ git python3 nodejs npm fzf ripgrep curl openssh-client

# CMD ["/bin/sh"]
CMD ["/usr/local/bin/nvim"]
