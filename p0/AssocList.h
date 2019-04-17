/*	 	 
 * Project 0 -- Part 1: AssocList.h (required for everyone) 
 ***************************************   
 *	
 * Your task is to complete the following AssocList class so that all
 * methods behave as expected and the class satisfies the IMap interface.	
 * The class is templated so that it may be used for various key (K) and 
 * value (V) types. The structure stores keys themselves, and pointers	 	 
 * to values. This is so the 'lookup' method may return a null pointer	 	 
 * when a key cannot be found. 'remove' returns true if a key-value is 
 * found and removed and false if no change was made. 'add' replaces 
 * an existing value for the input key or adds a new key-value pair. 
 * The ctor sets up an empty association list, the dtor properly cleans up 
 * the datastructure (freeing used memory) and 'size' reports the # of keys.   
 * (See IMap.h for more details.) There are various correct ways to complete 
 * the assignment, ask if you have questions. Search for "TODO" in this file.	 	 
 *
 ************************************
 */	 	 


#pragma once

#include "IMap.h"   
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


template <typename K, typename V>	 	 
class AssocList	 	 
	: public IMap<K,V>   
{
    // A private struct useful for links of the list 
    struct Link 
	{ 
		K k;   
		V* v;	 	 
		Link* next;	 	 

		Link(const K _k, V* const _v, Link* const _next) 
		    : k(_k), v(_v), next(_next)   
		{ 
		} 
	}; 

private: 
	// A counter for the total number of keys in the association list	 	 
    unsigned count;	 	 

	// A pointer to the root node 
    Link* root;	 	 

public: 
    AssocList()	 	 
	    : count(0), root(0)	 	 
	{
	}	 	 

	~AssocList() 
	{	
		while (root)	 	 
			remove(root->k); 
	}	

	// A method for mutably extending the map with a new key-value association	 	 
	void add(const K& key, V* const val)
	{ 
		// TODO: write add method

		Link* node = root;   

		// Follow the linked list until reaching null	 	 
		// or a node where the key matches 
        while (node && node->k != key)
			node = node->next;

		//if it exist update the value
		if(node)
			node->v = val;

		//if that key doesn't exist add it to the front
		else {
			node = new Link(key,val,root);
			root = node;
			//incriment the count	
			count++;
		}


		return;

	}	

	// A method for mutably deleting a key (and its value) from the current map 
	bool remove(const K& key)
	{   
		//if it's empty you can't remove
		if(size() == 0)
			return false;

		//if the first value is the key
		else if(root->k == key) {
			Link *curr = root;
			//set the root to the next
			root = root->next;
			delete curr;
			//decriment count
			count--;
		}
		else {
			//set up 2 pointers
			Link *prev = root;
			Link *curr = root->next;
			//read through curr
			while(curr != NULL) {
				//when you get a match break
				if(curr->k == key)
					break;
				//else look at the next updating pointers
				else {
					prev = curr;
					curr = curr->next;
				}
			}
			//if curr is null then you reached the end without finding it
			if(curr == NULL)
				return false;
			//skip the value and update
			else {
				prev->next = curr->next;
				delete curr;
				count--;
			}
		}
		//you should have found & removed it
		return true;
	} 
   
	// A method for looking up the value associated with a given key	 	 
	V* lookup(const K& key) const	 	 
	{	 	 
		// Start at the root	
		Link* node = root;   

		// Follow the linked list until reaching null	 	 
		// or a node where the key matches 
        while (node && node->k != key)
			node = node->next; 

		// Return the associated value, or null 
		if (node) 
			return node->v;	 	 
		else	 	 
			return 0;	 	 
	}
	 	 
	// A method for reporting the current number of keys in the map	 	 
	unsigned size() const   
	{	 	 
        return count;	 	 
	}	
};




