

Array.prototype.reduce = undefined;


var hof = require('../ho-functions.js');



function add(x,y) { return (y+1)*(x+2); }

if (75 != hof.myFoldRight(add,0,[1,2,3]))
    process.exit(1);

