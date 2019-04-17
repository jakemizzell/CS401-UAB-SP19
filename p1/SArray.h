/*   
 * Project 1 -- SArray reallocating array class (CS 401 and 501) 
 ************************************	 	 
 *
 * Your job is to finish writing this class to suit the 
 * set of tests provided. Be sure to read IArray.h and AArray.h
 * before you begin. Your SArray class should improve on the	 	 
 * efficiency of the CArray class by allocating a buffer twice	 	 
 * as large when needed. Look for "TODO"s that you must complete.	
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
class SArray 
    : public AArray<T>   
{ 
private:   
    unsigned capacity;

    // Use a private helper method to resize the current buffer?	 	 
    void reallocate(unsigned cap)	 	 
    {	 	 
        // Write a helper method to determine new size? 
        // cap = nextsize(cap);

        // TODO: Reallocate the current buffer to be	 	 
        //       at least twice as large
        if(capacity == 0) {
            capacity = 1;
        }
        else if(capacity == this->size())
            capacity = cap*2;
        else if(this->size()*2 < capacity)
            capacity = cap/2;
        //DONE
    }	 	 

public: 
    SArray()	 	 
        : capacity(0)	 	 
    {   
    }	 	 

    SArray(const AArray<T>& other)
        : AArray<T>(other), capacity(0)   
    {   
    } 

    virtual ~SArray()	
    {
    }	 	 
 
    virtual void insert(const T& elem, unsigned pos)	 	 
    {   
        if (pos > this->size())
            throw IArray<T>::ARRAY_OVERFLOW;


        // TODO: write an insert method	

        //if you have room and you're adding to the end just do it
        if(capacity > this->size() && pos == this->size()) 
            this->buffer[pos] = elem;

        else {
            reallocate(capacity);

            T* const newbuffer = new T[capacity];   
            for (unsigned i = 0; i < pos; ++i)   
                newbuffer[i] = this->buffer[i];
            newbuffer[pos] = elem;
            for (unsigned i = pos+1; i < this->size()+1; ++i)        
                newbuffer[i] = this->buffer[i-1];
            delete [] this->buffer; 
            this->buffer = newbuffer; 
        }  
        ++this->count;
        //DONE 	 
    }	 	 
	 	 
    virtual void insert(const IArray<T>& other, unsigned pos)	 	 
    {	 	 
        if (pos > this->size()) 
            throw IArray<T>::ARRAY_OVERFLOW;	 	 

        // TODO: write an insert method
        reallocate(capacity);

        T* const newbuffer = new T[capacity + other.size()];    
        for (unsigned i = 0; i < pos; ++i)   
            newbuffer[i] = this->buffer[i];      
        for (unsigned i = pos; i < pos+other.size(); ++i)   
            newbuffer[i] = other[i-pos];   
        for (unsigned i = pos+other.size(); i < this->size()+other.size(); ++i)      
            newbuffer[i] = this->buffer[i-other.size()]; 
        delete [] this->buffer; 
        this->buffer = newbuffer;
        this->count += other.size();
        //DONE
    }	 	 
	 	 
    virtual void remove(unsigned pos, unsigned num = 1)   
    {	 	 
        // TODO: write a remove method 
        if (pos+num > this->size()) 
            throw IArray<T>::ARRAY_OVERFLOW;

        if (num == 0) return; 

        reallocate(capacity);

        T* const newbuffer = new T[capacity - num];      
        for (unsigned i = 0; i < pos; ++i)   
            newbuffer[i] = this->buffer[i];      
        for (unsigned i = pos+num; i < this->size(); ++i)   
            newbuffer[i-num] = this->buffer[i];      
        delete [] this->buffer; 
        this->buffer = newbuffer;
        this->count -= num;
        //DONE
    }   

    virtual void clear()	 	 
    {   
        this->AArray<T>::clear();   
        // TODO: is this complete?
        capacity = 0;
        //DONE
    } 

    // An iterator for SArray instances   
    class Iter	 	 
        : public AArray<T>::Iter   
    {
        // TODO: Does more need to be implemented here?	 
    public:
        Iter(IArray<T>& other): 
            AArray<T>::Iter(other)
        {   
        }
        //DONE	 
    };   
};	



