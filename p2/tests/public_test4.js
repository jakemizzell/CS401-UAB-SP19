

var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var n = imp.interp_A(ast['+'](ast.n(4), ast['-'](ast.n(5), ast.x('z'))),
		     (x) => {if (x == 'z') return 2; else empty_store(x);});

if (7 == n)
{
    process.exit(0); 
}

process.exit(1);
