

var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var store = imp.interp_C({form: ':=', x: 'z', a: {form: '+', a0: {form: 'n', n: 2}, a1: {form: 'n', n: 7}}},
		     empty_store);

if (9 == store('z'))
{
    console.log("Pass"); 
}
else
	console.log("Fail: ", store('z'));

console.log(imp.interp_B(ast.or(ast.false(),ast.not(ast.and(ast.false(),ast.true())))));



/*var imp = require('../imp.js');
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
*/