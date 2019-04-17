#include <iostream>

#include "SArray.h"


int main()
{

        SArray<unsigned> arr;
    
        for (unsigned i = 0; i < 100; ++i)
            arr.push_back(i);
    
        for (unsigned i = 0; i < 100; ++i)
            if (arr[i] != i)
                std::cout << "Failed: " << i << std::endl;

        for(unsigned i = 0; i < arr.size(); ++i)
            std::cout << arr[i] << " ";
        arr.remove(99,1);


        for(unsigned i = 0; i < arr.size(); ++i)
            std::cout << arr[i] << " ";

    
    return 0;
}



