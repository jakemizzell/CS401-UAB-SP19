/*
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
    console.log("F0");

if (![1,1,1,2].equals(hof.myMap((ele)=>{if (ele==0) return 1; else return ele; },[0,1,0,2])))
    console.log("F1");
*/



Array.prototype.reduce = undefined;


var hof = require('../ho-functions.js');



function mul(x,y) { return x*y; }

if (5 != hof.myFoldLeft(mul,5,[]))
    console.log("F0");

if (hof.myMap((x)=>x+2,[6,7])[0] != 8)
    console.log("F1", hof.myMap((x)=>x+2,[6,7])[0]);
