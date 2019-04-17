

Array.prototype.reduce = undefined;


var hof = require('../ho-functions.js');



function mul(x,y) { return x*y; }

if (5 != hof.myFoldLeft(mul,5,[]))
    process.exit(1);

if (hof.myMap((x)=>x+2,[6,7])[0] != 8)
    process.exit(1);
