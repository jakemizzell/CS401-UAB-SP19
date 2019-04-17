/***************************************	 	 
 * Lab 4 -- HO functions practice in JavaScript	 	 
 * 
 * The goal of this lab is to write several standard higher-order functions   
 * in JavaScript. You must write a compose function, a map function, a left fold,   
 * a right fold, a filter function, and a reverse function.	 	 
 * 
 * Each is described in comments below. 
 *   
 ************************************ 
 */	 	 


exports.myCompose = myCompose;
exports.myMap = myMap; 
exports.myFoldLeft = myFoldLeft;	
exports.myFoldRight = myFoldRight;	 	 
exports.myFilter = myFilter;
exports.myReverse = myReverse; 


/************************************ 
 * Honor pledge (please write your name.)   
 *
 * I **firstname lastname** have completed this code myself, without
 * unauthorized assistance, and have followed the academic honor code.
 * 
 * Edit the code below to complete your solution. 
 *	
 ***************************************	 	 
 */	


function myCompose(f,g)   
{	 	 
    // TODO: return (f o g);
    //       that is, a function that returns f(g(x)) when invoked on x. 
    return x => f(g(x));
} 


function myMap(fn, lst)	 	 
{	
    // TODO: Write a function myMap that returns a copy of array lst	 	 
    //       where every element is transformed by function f.x
    //       Thus, for every index i, myMap(f,lst)[i] == f(lst[i])   

    // Hopefully it goes without saying, do not use the built-in Array.map function.

    // Can you implement this using myFoldLeft or myFoldRight (below)? 
    var arr = [];
    for(var i = 0; i < lst.length; i++)
        arr.push(fn(lst[i]));
    return arr;

}


function myFoldRight(fn, acc, lst)	 	 
{   
    // TODO: Write a right-hand fold function. That is, a fold function which 
    //       takes a fn = (ele, acc) => {...}, a function that combines one element 
    //       of the list and a current accumulator value and reduces this to a new accumulator	 	 
    //       value, and an initial accumulator acc and an array lst, and scans the	
    //       array from right-to-left using fn to reduce the array to a single value.   
   
    // Can you implement this using a loop (see myFoldLeft stubbed out below)?	 	 

    // Can you implement it instead using recursion? 

    // Hint: you may want to take a slice of an existing array using lst.slice(start,end)
    //       and/or combine two existing arrays into a new one using lst0.concat(lst1)	
    while (lst.length > 0) {
        var next = lst[lst.length-1];
        lst = lst.slice(0,lst.length-1);
        acc = fn(next,acc);
    } 	 
    return acc;

}   


function myFoldLeft(fn, acc, lst)	
{	 	 
    // TODO: A left-to-right fold function, analagous to the right-hand fold explained above.   
	 	 
    // Can you rewrite this function without using a loop or variable assignment? 
    while (lst.length > 0)	 	 
    {   
        var next = lst[0];   
        lst = lst.slice(1);	 	 
        acc = fn(next, acc); 
    }	 	 

    // TODO: what is returned here after the loop?	
    return acc; 	 
}	


function myFilter(pred, lst)	 	 
{ 
    // TODO: myFilter takes a predicate (a function yielding true or false for its input)   
    //       and an array lst, and returns a new list that contains only those elements satisfying pred	 	 

    // Can you implement this using myLeftFold or myRightFold?	 

/*    var init = [];
    return myFoldLeft((elm,acc) => {
        //var curr_lst = acc;
        //var curr_elm = elm;
        if(pred(elm)) {
            return acc.push(elm);
        }
        else{
            return acc;
        }
        
    }, init, lst);*/

    var arr = [];
    for(var i = 0; i < lst.length; i++)
        if(pred(lst[i]))
            arr.push(lst[i]);
    return arr;

}	 	 

	
function myReverse(arr)   
{
    // TODO: write a function that reverses an array 

    // Can you do this using a left or right fold?   
    var newArray = [];
    for (var i = arr.length - 1; i >= 0; i--)
        newArray.push(arr[i]);
    return newArray;
}   

 
