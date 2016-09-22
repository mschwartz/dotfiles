/**
 * master to manage proxy nodes
 * @type {exports}
 */

var pm = require('pm');

function proxyMaster(options){
    this._options = options || {};
    this._app = pm.createMaster({
        'pidfile' : '/tmp/node-proxy-server.pid'
    })
}

proxyMaster.prototype.start = function(){
    var options = this._options

    this._app.register('proxy-server',__dirname + '/proxy-server.js', {
        listen : options.port || 8234,
        children: options.instance || 1
    },process.argv)

    this._app.on('giveup', function (name, num, pause) {
        console.log('giveup', name, num, pause)
    })

    this._app.dispatch()
}

proxyMaster.prototype.stop = function(){

}

module.exports = proxyMaster
