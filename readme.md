# Neovim in docker

## Step 1: clone this repo

```sh
git clone git@github.com:eduardoarandah/docker-neovim.git && cd docker-neovim
```

## Step 2: build the image

```sh
docker build . -t dnvim
```

## Step 2: create the volume dnvim

So neovim doesn't have to download everything on each run

```sh
docker volume create dnvim
```
## Step 3: add an alias to your shell

- This mounts the volume `dnvim` for the plugins
- Mounts current directory
- Mounts your `~/.config` directory so you don't have to reconfigure everything from inside

```sh
alias dnvim='docker run --rm -it -v dnvim:/root/.local -v ${PWD}:/app  -w /app -v ~/.config/:/root/.config dnvim'
```
