/*
 * Lab 1 -- AArray abstract class	 	 
 ************************************	 	 
 *   
 * This is an abstract class defining behaviors (methods, member functions)	 	 
 * and properties (fields, data members) that our arrays will have in common.	 	 
 * Look for instances of "TODO" and finish this class. 
 *
 ***************************************	 	 
 */ 

 
#pragma once	 	 

#include "IArray.h"	 	 


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


// This is an abstract class we can extend 
// on which to base AArray subclasses
template<typename T>   
class AArray 
    : public IArray<T> 
{	 	 
protected: 
    T* buffer;
    unsigned count;

public:   
    // A default constructor   
    AArray() 
        : buffer(0), count(0)	 	 
    {   
    }
	
    // A copy constructor	
    AArray(const AArray<T>& other)	 	 
        : buffer(0), count(0)	
    { 
        insert(other,0);	 	 
    }	 	 

    // A virtual destructor   
    virtual ~AArray()	 	 
    { 
        // Clear the array	 	 
        clear();
    }

    // Member functions for inserting an element/array at a given index   
    virtual void insert(const T& elem, unsigned pos) = 0; 
    virtual void insert(const IArray<T>&, unsigned pos) = 0;	 	 

    // Member function for appending a new element to the front	 	 
    virtual void push_front(const T& elem)	 	 
    {
        insert(elem,0);   
    }	 	 

    // Member function for appending a new element to the back   
    virtual void push_back(const T& elem) 
    {   
        insert(elem,size()); 
    }

    // A method for looking up an existing value in the array
    virtual int find(const T& elem) const   
    {	
        // TODO: Return -1 if the element doesn't exist, or its index
        for(int i = 0; i < size(); ++i) {
            if(buffer[i] == elem)
                return i;
        }

        return -1;
        //DONE
    }   
   
    // A method for returning if an element exists in the array	
    virtual bool contains(const T& elem) const   
    {
        if (find(elem) >= 0)
            return true;
        else
            return false;	 	 
    } 

    // Methods for erasing by position/number   
    virtual void remove(unsigned pos, unsigned num) = 0; 

    // Method for getting a reference to an element at a particular index
    virtual T& operator [](unsigned pos) 
    {	 	 
        return buffer[pos];   
    }   

    // Method for getting a const reference to an element at a particular index
    virtual const T& operator [](unsigned pos) const
    {	
        return buffer[pos];	 	 
    } 

    // Method for assigning to an exisitng Array
    virtual void operator =(const IArray<T>& other)	 	 
    {
        clear();	 	 
        insert(other,0); 
    }   
 
    // Method for clearing an existing array and setting size=0 
    virtual void clear() 
    { 
        // TODO: clear the array instance and delete any	 	 
        //       associated memory it "owns"
        if(buffer)
            delete [] buffer;
        buffer = 0;
        count = 0;
        //DONE 	 	 
    }

    // Method for determining equality of two arrays   
    virtual bool operator ==(const IArray<T>& other) const
    { 
        // TODO: return true iif *this and other are deeply equal
        if(count == other.size()) {
            for(int i = 0; i < count; i++) {
                if(buffer[i] != other[i])
                    return false;
            }
            return true;
        }
        return false;
        //DONE 
    }   

    // Method for determining inequality of two arrays 
    virtual bool operator !=(const IArray<T>& other) const 
    {	 	 
        // calls == and returns the inverse
        // This is the same as !((*this) == other)	 	 
        return !this->operator ==(other);   
    }   

    // A method for reporting the current number of elements in the array 
    virtual unsigned size() const	 	 
    { 
        return count;	 	 
    }	 	 
}; 



