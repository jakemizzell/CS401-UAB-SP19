
var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var store = imp.interp_C(ast[';'](ast[':=']('q',ast.n(2)),
				  ast.while(ast['<='](ast.x('q'), ast.n(50)),
					    ast[':=']('q', ast["*"](ast['x']('q'),ast['x']('q'))))),
		     empty_store);

if (256 == store('q'))
{
    process.exit(0); 
}

process.exit(1);
