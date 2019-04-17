

Array.prototype.reduce = undefined;


var hof = require('../ho-functions.js');



function mul(x,y) { return x*y; }

if (10 != hof.myFoldRight(mul,5,[2])
    || hof.myFoldRight(mul,5,[2]) != hof.myFoldLeft(mul,5,[2]))
    process.exit(1);

