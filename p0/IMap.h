/*	
 * Project 0 -- IMap interface
 *************************************** 
 *   
 * You do not need to modify this file, but you	 	 
 * should read over it carefully before starting.	
 *   
 ************************************   
 */	

   
#pragma once   


// This is an abstract class we can use as an interface for map objects   
template<typename K, typename V>   
class IMap   
{	 	 
public:	 	 
	// A method for mutably extending the map with a new key-value association	 	 
	virtual void add(const K& key, V* const val) = 0;
	 	 
	// A method for mutably deleting a key (and its value) from the current map	 	 
	virtual bool remove(const K& key) = 0;

	// A method for looking up the value associated with a given key   
	virtual V* lookup(const K& key) const = 0;	 	 

	// A method for reporting the current number of keys in the map 
	virtual unsigned size() const = 0;
};	 	 

   

