/*
 * Project 1 -- CArray concrete class
 ************************************ 
 *
 * Your job is to finish writing this class to suit the   
 * set of tests provided. Be sure to read IArray.h and AArray.h 
 * before you begin. Look for "TODO"s that you must complete.	
 *	 	 
 ***************************************   
 */	 	 


#pragma once
 
#include "AArray.h"   


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


// This is a simple managed array class that will allocate   
// new space to grow/shrink its buffer "under the hood"	 	 
template<typename T>	
class CArray 
    : public AArray<T>
{
public:	 	 
    CArray()	
    {	
    } 

    CArray(const AArray<T>& other)
        : AArray<T>(other)	 	 
    { 
    }

    virtual ~CArray()	 	 
    {	 	 
    }   

    virtual void insert(const T& elem, unsigned pos) 
    {   
        if (pos > this->size()) 
            throw IArray<T>::ARRAY_OVERFLOW;   
   
        T* const newbuffer = new T[this->size() + 1];   
        for (unsigned i = 0; i < pos; ++i)   
            newbuffer[i] = this->buffer[i];
        newbuffer[pos] = elem;
        for (unsigned i = pos+1; i < this->size()+1; ++i)	 	 
            newbuffer[i] = this->buffer[i-1];
        delete [] this->buffer; 
        this->buffer = newbuffer;   
        ++this->count;   
    }	 	 

    virtual void insert(const IArray<T>& other, unsigned pos)	 	 
    {   
        if (pos > this->size())	 	 
            throw IArray<T>::ARRAY_OVERFLOW;

        T* const newbuffer = new T[this->size() + other.size()];	
        for (unsigned i = 0; i < pos; ++i)   
            newbuffer[i] = this->buffer[i];	 	 
        for (unsigned i = pos; i < pos+other.size(); ++i)   
            newbuffer[i] = other[i-pos];   
        for (unsigned i = pos+other.size(); i < this->size()+other.size(); ++i)	 	 
            newbuffer[i] = this->buffer[i-other.size()]; 
        delete [] this->buffer; 
        this->buffer = newbuffer;
        this->count += other.size();
    }   
   
    virtual void remove(unsigned pos, unsigned num = 1)   
    { 
        if (pos+num > this->size()) 
            throw IArray<T>::ARRAY_OVERFLOW;	

        if (num == 0) return;	 	 
	 	 
        T* const newbuffer = new T[this->size() - num];	 	 
        for (unsigned i = 0; i < pos; ++i)   
            newbuffer[i] = this->buffer[i];	 	 
        for (unsigned i = pos+num; i < this->size(); ++i)   
            newbuffer[i-num] = this->buffer[i];	 	 
        delete [] this->buffer; 
        this->buffer = newbuffer;
        this->count -= num;
    }
   
    // An iterator for CArray instances   
    class Iter	 	 
        : public AArray<T>::Iter	 	 
    {	 	 
    public: 
        // TODO: is anything needed here?

        Iter(IArray<T>& other): 
            AArray<T>::Iter(other)
        { 
        }

        //DONE	 	 
    }; 
}; 



