var http = require('http');
var Socket = require('net').Socket;
var url = require('url');
var dns = require('dns');
var request = require('request');
var qs = require('querystring');
var pm = require('pm');
var BufferHelper = require('bufferhelper');



(function proxy(){
	this.options = {};
	this.proxyNode = new proxyNode(this.options);
	

	function proxyNode(options){
		//初始化Node服务器
		this.httpProxy = new httpProxy(options);
		this.httpsProxy = new httpsProxy(options);
		var server = http.createServer(serverHandler);
		this.httpProxy.init(server);
		this.httpsProxy.init(server);
	}

	function serverHandler(req,res){
		headerProcessor(req.headers);
		var options = {headers:req.headers,followRedirect:false,timeout:30000};
		switch(req.method.toLowerCase()){
			case 'post':
					var bufferhelper = new BufferHelper();
					bufferhelper.load(req,function(err,body){
						options.form = qs.parse(body);
						request_handler('post',req,options,res);
					});
					break;
			case 'get':
					request_handler('get',req,options,res);
					break;
			default:
					res.end('no support method');
					break;
		}
	}

	function request_handler(method,req,options,res){
		var r = request[method](req.url,options);
		r.on('error',function(e){
			if(argv.log_error)
				console.trace(e);
			res.end();
		});
		r.pipe(res);
	}


	function headerProcessor(headers) {

	  	function normalizeHeaderCase(header){
		  	var result = {
			    "content-md5": "Content-MD5",
			    "dnt": "DNT",
			    "etag": "ETag",
			    "last-event-id": "Last-Event-ID",
			    "tcn": "TCN",
			    "te": "TE",
			    "www-authenticate": "WWW-Authenticate",
			    "x-dnsprefetch-control": "X-DNSPrefetch-Control"
		  	}[header.toLowerCase()];
		  	if (result) {
		    	return result;
		  	}
		  	return header
		    	.split("-")
		    	.map(function (text) {
		      		return text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();
		    	})
		    	.join("-");	
	  	}
	  	Object.keys(headers).forEach(function(h){
	  		var k = normalizeHeaderCase(h);
	  		if(k != h){
	  			headers[k] = headers[h];
	  			delete 	headers[h];
	  		}
	  	});
	}

	function httpProxy(options){
		//初始化http代理模块
		this.init = function(server){
			pm.createWorker().ready(function (socket, port) {
				server.emit('connection', socket);
			});
		}
	}



	function httpsProxy(options){
		//初始化https代理模块
		
		function targetReceiver(hosts,ua){
			var target = new Socket();//target socket
			target.setTimeout(10000,function(){
				target.destroy();
			});
			ua.on('error',function(e){
				if(argv.log_error)
					console.trace(e);
			});
			target.on('error',function(e){
				if(argv.log_error)
					console.trace(e);
			});
			target.on('close',function(){
				ua.destroy();
			});
			ua.on('close',function(){
				target.destroy();			
			});

			target.on('connect',function(){
				if(ua.write('HTTP/1.1 200 Connection Established\r\n\r\n')){
					ua.pipe(target);
					target.pipe(ua);
				}else{
					target.destroy();
				}
			});
			target.connect(hosts.port,hosts.host);

		}
		function connection_handler(req,ua,head){
			var hosts = url.parse('https://'+req.headers.host);
			if(hosts == undefined || !hosts){//have not target host
				return ua.end();
			}

			hostToIP(hosts.hostname,function(err,address){
				if(address){
					hosts.host = address;
					targetReceiver(hosts,ua);
				}else{
					ua.end();
				}
			});
		}

		this.init = function(server){
			server.on('connect',connection_handler);
		}
	}

	function hostToIP(host,cb){
		dns.lookup(host,cb);
	}
})();



