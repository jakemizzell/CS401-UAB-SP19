

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
    arr.insert(arr,1);
	arr.remove(2,5);

    if (arr.contains(1)) return 1;

    if (!arr.contains(5)) return 1;

    if (arr.contains(15)) return 1;
    
    return 0;
}

