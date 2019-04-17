/***************************************
 * Lab 0 -- Part 2: reverse.cpp   
 * 
 * The goal of this task is to use a linked list to read in a sequence of integers   
 * via STDIN and then print them to STDOUT in reverse order (one per line). 
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


struct linkedlist 
{	 	 
    int value; 
	linkedlist* next;	 	 
}; 

   
int main(int argc, const char** argv) 
{   
	// Setup a root node pointer and a temporary variable n	
	linkedlist* node = 0;   
	int n; 

	// Push each value onto the *front* of the linked list
while (std::cin >> n)
{
        // Save ptr to the old root as variable next
        linkedlist* next = node;
        node = new linkedlist();
        node->next = next;
        node->value = n;
}

// Print each value in the linked list, in order
for (linkedlist* cur = node; cur != 0; cur = cur->next)
        std::cout << cur->value << std::endl; 
   
	// Cleanup each link when finished 
	for (linkedlist* cur = node; cur != 0; cur = cur->next) 
		delete cur; 

	// Exit with error code 0 (success)   
	return 0;	 	 
}	 	 