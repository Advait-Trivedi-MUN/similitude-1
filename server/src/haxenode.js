// Generated by Haxe 3.4.3
if (process.version < "v4.0.0") console.warn("Module " + (typeof(module) == "undefined" ? "" : module.filename) + " requires node.js version 4.0.0 or higher");
(function () { "use strict";
var Main = function() { };
Main.main = function() {
	var server = js_node_Http.createServer(function(request,response) {
		response.setHeader("Content-Type","text/plain");
		response.writeHead(200);
		response.end("Hello World\\n");
	});
	server.listen(1337,"localhost");
	console.log("Server running at http://127.0.0.1:1337/");
};
var haxe_io_Bytes = function() { };
var js_node_Http = require("http");
var js_node_buffer_Buffer = require("buffer").Buffer;
Main.main();
})();
