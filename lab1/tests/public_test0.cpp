

#include <iostream>

#include "../CArray.h"



int main()
{
    CArray<int> arr;
	arr.push_back(5);
	arr.push_front(4);
	arr.push_front(3);

	int eq[5] = {3,4,5};
	for (unsigned i = 0; i < arr.size(); ++i)
		if (eq[i] != arr[i])
			return 1;

    return 0;
}


