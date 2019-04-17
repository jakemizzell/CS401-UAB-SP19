/*************************************** 
 * Lab 3 -- Part 2: reverse.js   
 *   
 * The goal of this task is to read in a sequence of integers read   
 * via STDIN and then print them to STDOUT in reverse order (one per line). 
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
          nums.push(chunk.trim()); 
      });   

	 	 
rl.on('close',
      () =>
      {	 	 
          nums.reverse(); 
          // TODO: print out nums, one per line   
          // Print them out, one per line 
          console.log(nums.join("\n"))
      });	

   

