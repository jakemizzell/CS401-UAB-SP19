

var imp = require('../imp.js');
var ast = require('../ast.js');


var empty_store = (x) => console.log(`Error: undefined variable ${x}`);


var store = imp.interp_C({form: ':=', x: 'z', a: {form: 'n', n: 3}},
		     empty_store);

if (3 == store('z'))
{
    process.exit(0); 
}


process.exit(1);




