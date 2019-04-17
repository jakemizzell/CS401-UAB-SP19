/*	 	 
 * Project 0 -- Part 2: BinaryTree.h (required for 501, bonus for 401) 
 *************************************** 
 *	 	 
 * Your task is to complete the following BinaryTree class so that all   
 * methods behave as expected and the class satisfies the IMap interface.   
 * (See IMap.h for details.) There are various correct ways to complete	
 * the assignment, ask if you have questions. Search for "TODO" in this file.   
 *   
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
class BinaryTree	
	: public IMap<K,V> 
{ 
    // A private struct useful for links of the list 
    struct Node	 	 
	{ 
		K k;   
		V* v;	 	 
		Node* lhs;   
		Node* rhs;

	    Node(const K _k, V* const _v, Node* const _lhs, Node* const _rhs)   
	        : k(_k), v(_v), lhs(_lhs), rhs(_rhs)	 	 
		{   
		}	 	 
	}; 

private:	 	 
	// A counter for the total number of keys in the BST
    unsigned count; 

	// A pointer to the root node   
    Node* root; 

	Node** findnode(const K& key)   
	{	 	 
		// Start at the root	 	 
		Node** nodeptr = &root;	

		// Traverse the BST until reaching null   
		// or a node where the key matches   
		// NB: *nodeptr is a pointer to a node	 	 

        // TODO: finish findnode method

        while ((*nodeptr) && (*nodeptr)->k != key) {	 	 
			// Move left or right depending on node's field k	 	 
			if ((*nodeptr)->k > key)
				nodeptr = &((*nodeptr)->lhs);	 	 
		    else	 	 
				nodeptr = &((*nodeptr)->rhs);
		}

		// Return the position we found, whether a node 
		// exists for key or not
		return nodeptr;	 	 
	}	 	 

	void deletenode(Node** const nodeptr)   
	{	 	 
		// Takes a pointer to a pointer to a node,
		// deletes the node, and replaces the node pointer   
		Node* const node = *nodeptr;   
		if (node->lhs == 0) 
		{	 	 
			// LHS is null, replace root with root->rhs
			*nodeptr = node->rhs; 
			delete node; 
		}	 	 
		else if (node->rhs == 0)   
		{	 	 
			// TODO: finish this case
			*nodeptr = node->lhs;
			delete node;   
		}	 	 
		else 
		{ 
			// Both exist, find immediate successor... 
			Node** succptr = &(node->rhs);   
			// NB: (*succptr) is a pointer to the successor, **succptr   
			while ((*succptr)->lhs)   
				succptr = &((*succptr)->lhs);   
            // Swap the K,V for the successor with node...   
			node->k = (*succptr)->k; 
			node->v = (*succptr)->v;	 	 
			// And recursively delete the successor in turn.   
			deletenode(succptr); 
		}	
	}   

public:	 	 
    BinaryTree()   
	    : count(0), root(0) 
	{	 	 
	}

	~BinaryTree() 
	{   
		while (root)	 	 
			remove(root->k);   
	}
 
	// A method for mutably extending the BST with a new key-value association 
	void add(const K& key, V* const val)   
	{
		// Find the correct position in the tree 
		Node** const nodeptr = findnode(key); 
		//std::cout << "Size: " << size() << std::endl;

		// Modify the discovered node, or insert a new one 
		if (*nodeptr) {	
			//std::cout << "UPDATE: " << std::endl;
			(*nodeptr)->v = val;
		}
		else	 	 
		{	 	 
            (*nodeptr) = new Node(key,val,NULL,NULL);  
            count++; 
		}   
	}   

	// A method for mutably deleting a key (and its value) from the current BST   
	bool remove(const K& key)   
	{
		// Find the correct position in the tree	
		Node** const nodeptr = findnode(key);	 	 

		// If a node was discovered, delete it 
		if (*nodeptr)
		{
			deletenode(nodeptr);
			--count;	 	 
			return true; 
		}   
		else	 	 
			return false;

	} 
	 	 
	// A method for looking up the value associated with a given key   
	V* lookup(const K& key) const	 	 
	{   
		// Find the correct node in the tree
		Node* node = root;	 	 

		// Traverse the BST until reaching null
		// or a node where the key matches	 	 
        while (node && node->k != key)	 	 
			// Move left or right depending on node's field k	 	 
			if (node->k > key)
				node = node->lhs;	 	 
		    else	 	 
				node = node->rhs; 

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
   

