# One-liner Dev Environment Setup (git + go + tmux + vim)

## Supported OS

- Centos

## Screenshot

![](https://github.com/iamjinlei/env/raw/master/imgs/screenshot.png)

## Installation

Execute the one liner below to get everything setup for you

```
pushd ~/ && curl -LSso setup.sh https://raw.githubusercontent.com/iamjinlei/env/master/centos.sh && bash setup.sh && rm setup.sh && popd
```

To enable powerline symbol, add fonts to your local host. Run fonts/install.sh and select powerline font in your terminal preferences.
