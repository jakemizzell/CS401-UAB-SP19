

var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var store = imp.interp_C(ast[';'](ast[':=']('q',ast.n(3)), ast[';'](ast[':=']('m',ast.x('q')), ast.if(ast.true(), ast[':=']('q', ast['n'](8)), ast.skip()))),
		     empty_store);

if (8 == store('q') && store('m') == 3)
{
    process.exit(0); 
}

process.exit(1);




