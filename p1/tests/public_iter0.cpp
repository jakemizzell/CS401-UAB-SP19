
#include <iostream>

#include "../CArray.h"



int main()
{
    CArray<int> arr;
	arr.push_back(5);
	arr.push_front(4);
	arr.push_back(7);
	arr.push_front(3);
	arr.insert(6,3);
	arr.insert(arr,0);
	arr.remove(2,5);

    int eq[5] = {3,4,5,6,7};
    int i = 0;
    for (CArray<int>::Iter it(arr); it; ++it)
    {
        if (*it != eq[i])
            return 1;
        ++i;
    }
    if (i != 5) return 1;
    
    return 0;
}

