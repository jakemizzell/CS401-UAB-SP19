

#include <iostream>

#include "../CArray.h"


int main()
{
    CArray<char> arr;
    CArray<char> arr0;
    arr0.push_back('a');
    arr0.push_back('b');
    arr0.push_back('c');
    arr.push_front('a');
    arr.push_front('d');
    arr.push_front('c');
    arr.insert(arr0,1);
    arr.insert(arr0,4);
    arr.insert(arr0,2);

    arr.remove(0,3);
    
    if (arr.size() != 9) return 1;
    
    return 0;
}


