
Array.prototype.reverse = undefined;


var hof = require('../ho-functions.js');



Array.prototype.equals = function(arr)
{
    if (this.length != arr.length) return false;
    for (var i = 0; i < arr.length; ++i)
	if (arr[i] !== this[i]) return false;
    return true;
}

if (![].equals(hof.myReverse([])))
    process.exit(1);

if (![1,1,1,2].equals(hof.myMap((ele)=>{if (ele==0) return 1; else return ele; },[0,1,0,2])))
    process.exit(1);

