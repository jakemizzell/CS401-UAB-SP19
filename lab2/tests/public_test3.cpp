
#include "../Finally.h"


int count = 20;


void final()
{
    count += 5;
}


int main()
{
    try
    {
        Finally fin(&final);
        {
            Finally fin2(fin);
            throw 0;
            count *= 3;
        }
        count *= 7;
    }
    catch (int ex)
    {
        count *= 2;
    }

    // Note: the finalizer runs before the catch block!
    if (count != 60) return 1;

    return 0;
}
