

Array.prototype.reverse = undefined;


var hof = require('../ho-functions.js');



Array.prototype.equals = function(arr)
{
    if (this.length != arr.length) return false;
    for (var i = 0; i < arr.length; ++i)
	if (arr[i] !== this[i]) return false;
    return true;
}

if (![2].equals(hof.myReverse([2])))
    process.exit(1);

