
#include "../Finally.h"


int count = 354;


void finalizer()
{
    count = 13;
}


int main()
{
    try
    {
        Finally fin(&finalizer);
        throw 1;
        // Doesn't reach here
        count += 16;
    }
    catch (int ex)
    {
        count++;
    }

    // At this point the finalizer function should have been properly invoked
    if (count != 14) return 1;

    return 0;
}


