

#include <iostream>

#include "../SArray.h"



int main()
{
    SArray<int> arr;
	arr.push_back(1);
	arr.push_front(2);
	arr.push_back(3);
	arr.push_front(4);
	arr.push_back(5);
	arr.push_front(6);
	arr.push_back(7);
	arr.push_front(8);
	arr.push_back(9);
	arr.push_front(10);

    if (arr[3] != 4) return 1;
    
    if (arr.size() != 10) return 1;
    
    return 0;
}


