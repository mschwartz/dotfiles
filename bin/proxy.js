var http = require('http'),
    httpProxy = require('http-proxy');

//
// Create your proxy server and set the target in the options.
//
httpProxy.createProxyServer({target:'http://snowdog:8080'}).listen(8000); // See (†)

