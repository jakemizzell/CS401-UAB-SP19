

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

    if (arr.find(3) != 0) return 1;

    if (arr.find(5) != 2) return 1;

    if (arr.find(6) != 3) return 1;

    if (arr.find(15) >= 0) return 1;
    
    return 0;
}

