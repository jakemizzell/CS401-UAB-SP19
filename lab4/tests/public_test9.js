


Array.prototype.filter = undefined;


var hof = require('../ho-functions.js');



Array.prototype.equals = function(arr)
{
    if (this.length != arr.length) return false;
    for (var i = 0; i < arr.length; ++i)
	if (arr[i] !== this[i]) return false;
    return true;
}

var greaterThanFive = (x) => x > 5;

if (![6,7,8,7,6].equals(hof.myFilter(greaterThanFive, [1,2,3,4,5,6,7,8,0,7,6,5,4,3,2,1])))
    process.exit(1);




