
#include "../Finally.h"


int count = 666;


void finalizer()
{
    count += 34;
}


int main()
{
    try
    {
        Finally fin(&finalizer);
        {
            Finally fin2(fin);
            throw 1;
            count += 3;
        }
        count += 7;
    }
    catch (int ex)
    {
        count++;
    }

    if (count != 735) return 1;

    return 0;
}


