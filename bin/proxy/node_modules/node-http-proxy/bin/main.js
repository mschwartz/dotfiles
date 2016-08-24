/**
 * tu run proxy-server
 * Created by wddqing on 15/2/3.
 */

//console.log(process.argv);
var commander = require('commander');
commander.option('-p --port [i]')
		.option('-i --instance [i]')
		.parse(process.argv);
var argv = {};

['instance','port'].forEach(function(k){
	if(commander[k] != undefined){
		argv[k] = commander[k];
	}
});

var ProxyMaster = require('../lib/proxy-master')

var proxymaster = new ProxyMaster(argv)

proxymaster.start();
