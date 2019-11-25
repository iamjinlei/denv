### Pull go pkg into src dir for vim-go to navigate 

```bash
# example: goget github.com/iamjinlei/denv

function goget { http_proxy=http://127.0.0.1:1087 https_proxy=http://127.0.0.1:1087 GO111MODULE=off go get -u $1; }
export -f goget
```

