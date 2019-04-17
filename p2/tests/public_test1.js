

var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var store = imp.interp_C({form: ':=', x: 'z', a: {form: '+', a0: {form: 'n', n: 2}, a1: {form: 'n', n: 7}}},
		     empty_store);

if (9 == store('z'))
{
    process.exit(0); 
}

process.exit(1);




