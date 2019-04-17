/***************************************	 	 
 * Lab 0 -- Part 1: sort.cpp 
 *
 * The goal of this task is to use an bufferay to sort a sequence of numbers	 	 
 * and to print the numbers read via STDIN to STDOUT in increasing order (one per line). 
 *	 	 
 ************************************   
 */ 


#include <iostream>	 	 



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

void bubblesort(int *, int);


int main(int argc, const char** argv)
{ 
	// Allocate space for up to 500 numbers (no test will exceed this size)
	int buffer[500];   

	// Push each integer read into the bufferay, in order	 	 
	// Note that std::cin >> n reads the next number into variable   
	// and returns true or returns false if EOF is reached (really, a falsy object).   
	int n,end;
	for (end = 0; std::cin >> n; ++end) {
		buffer[end] = n; 
	}          

	// TODO: Use a sorting algorithm of your choice
	//       (e.g., bubblesort, insertionsort, quicksort) 
	//       to sort the numbers in buffer (increasing order)   
	// ... 
    bubblesort(buffer, end);

	// Print out integers in sorted order (one per line)
	for (int i = 0; i < end; ++i)	 	 
		std::cout << buffer[i] << std::endl;   
	 	 
	// Exit with error code 0 (success)   
	return 0;
}	 	 

void bubblesort(int *buffer, int end) {
	for (int i = 0; i < end-1; i++) {
        for (int j = 0; j < end-i-1; j++) {
            if (buffer[j] > buffer[j+1]) { 
                // swap buffer[j+1] and buffer[i] 
                int temp = buffer[j]; 
                buffer[j] = buffer[j+1]; 
                buffer[j+1] = temp; 
            } 
        }
    }
}


