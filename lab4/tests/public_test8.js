


var hof = require('../ho-functions.js');



Array.prototype.equals = function(arr)
{
    if (this.length != arr.length) return false;
    for (var i = 0; i < arr.length; ++i)
	if (arr[i] !== this[i]) return false;
    return true;
}

if (![1,2,3,4].equals(hof.myFoldRight((x,lst)=>lst.concat([x]),[],[4,3,2,1])))
    process.exit(1);



