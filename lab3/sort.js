/*************************************** 
 * Lab 3 -- Part 1: sort.js   
 *   
 * The goal of this lab is to sort a sequence of integers read	 	 
 * via STDIN and then print them (sorted) to STDOUT (one per line).   
 * 
 ************************************	 	 
 */	 	 

var readline = require('readline');	 	 


/************************************   
 * Honor pledge (please write your name.)	 	 
 *	
 * I Jake Mizzell have completed this code myself, without   
 * unauthorized assistance, and have followed the academic honor code.	 	 
 *   
 * Edit the code below to complete your solution.
 *	 	 
 ***************************************   
 */ 


var rl = readline.createInterface({   
    input: process.stdin, 
    output: process.stdout,	 	 
    terminal: false   
}); 

var nums  = [];	

rl.on('line',	 	 
      (chunk) =>
      {
          //console.log("Found num: " + chunk.trim())   
          // TODO: add the next number to nums   
          // hint, you might use: parseInt(num) -> str	 
          nums.push(parseInt(chunk));
      });


rl.on('close',	
      () =>	 	 
      {   
          // Sort the array of integers	
          // ... 
          nums.sort((a, b) => a - b);
          // Turn each integer back into a string	 	 
          nums.map((n) => ""+n);	 	 
          // Print them out, one per line 
          console.log(nums.join("\n"))	 	 
      });

