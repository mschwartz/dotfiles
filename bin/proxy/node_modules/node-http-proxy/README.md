node-http-proxy
===============

a node http(s) proxy server with single process mode or multi process mode(set parameter '-i')

## Install node-http-proxy

```bash
$npm install -g node-http-proxy
```

## Server Start

```bash
$nproxy start -p 9999 -i 1
#start proxy server
#create child process 1 (default 1) or more(limit by cpu cores)
#on port 9999(default 8234)

$nproxy stop #stop server

```

## Use in code
```javascript
var ProxyMaster = require('node-http-proxy').proxyMaster;

var proxymaster = new ProxyMaster({instance:1,port:8123});

proxymaster.start();
```


## Useage
```bash
$curl -x 127.0.0.1:9999 http://www.google.com/
```

## Something need to do

1.finished nproxy command<br>
2.support other http method
