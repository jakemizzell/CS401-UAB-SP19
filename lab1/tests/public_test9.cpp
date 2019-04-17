

#include <iostream>

#include "../CArray.h"


int main()
{
    CArray<int> arr;
    CArray<int> arr0;
    arr.clear();
    arr.clear();
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.push_back(0);
    arr.clear();
    arr.clear();
    arr0.clear();
    if (arr0.size() > 0 || arr.size() > 0) return 1;

    return 0;
}


