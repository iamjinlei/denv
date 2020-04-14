### Bash

```bash
# example: goget github.com/iamjinlei/denv

export PROXY=http://127.0.0.1:1081
function goget { git config --global http.proxy $PROXY; http_proxy=$PROXY https_proxy=$PROXY GO111MODULE=off go get $1; git config --global --unset http.proxy; }

export -f goget
```

