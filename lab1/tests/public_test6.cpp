

#include <iostream>

#include "../CArray.h"


int main()
{
    CArray<int> arr;
    CArray<int> arr0;
    arr0.push_back(0);
	arr.insert(arr0,0);
	arr.push_back(1);
	arr.push_front(2);
	arr.push_back(3);
	arr.push_front(4);
	arr.push_back(5);
	arr.push_front(6);
	arr.push_back(7);
    arr.remove(5);

    if (arr.size() != 7) return 1;
  
    if (arr[0] != 6 || arr[5] != 5) return 1;
    
    return 0;
}
