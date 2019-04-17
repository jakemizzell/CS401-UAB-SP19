/*
 * Lab 1 -- IArray interface	 	 
 ************************************ 
 *   
 * You do not need to modify this file, but you	 	 
 * should read over it carefully before starting.   
 * 
 ***************************************	
 */ 


#pragma once	


// This is an abstract class we can use as an interface for Array objects
template<typename T>
class IArray   
{   
public: 
    // Enumerate exceptions we can throw	 	 
    enum Exception { ARRAY_OVERFLOW=0xff }; 

    // A member function for inserting an element/array at a given index	
    virtual void insert(const T& elem, unsigned pos) = 0;   
    virtual void insert(const IArray<T>&, unsigned pos) = 0; 

    // Member functions for appending a new element to the array	 	 
    virtual void push_front(const T& elem) = 0;	 	 
    virtual void push_back(const T& elem) = 0;   

    // A method for looking up an existing value in the array	 	 
    virtual int find(const T& elem) const = 0;   
    virtual bool contains(const T& elem) const = 0;   

    // Methods for removing elements by position+number 
    virtual void remove(unsigned pos, unsigned num) = 0; 

    // Method for getting a reference to an element at a particular index
    virtual T& operator [](unsigned pos) = 0;
    virtual const T& operator [](unsigned pos) const = 0; 

    // Method for assigning to an exisitng Array 
    virtual void operator =(const IArray<T>& other) = 0;   

    // Method for clearing an existing array and setting size=0
    virtual void clear() = 0; 

    // Methods for determining equality of two arrays 
    virtual bool operator ==(const IArray<T>& other) const = 0;   
    virtual bool operator !=(const IArray<T>& other) const = 0;	 	 

    // A method for reporting the current number of elements in the array   
    virtual unsigned size() const = 0;   
};	



