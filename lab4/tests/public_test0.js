

var hof = require('../ho-functions.js');



function add3(x) { return x+3; }

if (7 != hof.myCompose(add3,add3)(1))
    process.exit(1);





