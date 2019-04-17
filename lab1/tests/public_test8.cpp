

#include <iostream>

#include "../CArray.h"


int main()
{
    CArray<int> arr;
    CArray<int> arr0;
    arr0.push_back(0);
    arr.push_front(15);
    arr.insert(1,1);
    try
    {
	    arr.insert(arr0,3);
        return 1;
    }
    catch (IArray<int>::Exception e)
    {
        if (e == IArray<int>::ARRAY_OVERFLOW)
        {
            arr.insert(0,0);
            if (arr[0] == 0 && arr[1] == 15 && arr[2] == 1)
                return 0;
        }
    }
    
    return 1;
}



