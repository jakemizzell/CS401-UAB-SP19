

#include <iostream>
#include "../ShapesStructs.h"


int main()
{
    void* rect = newRectangle(0,0,50,100);
    vtable(rect)->movePos(rect,20,10);
    vtable(rect)->scaleBy(rect,-2.0);
    vtable(rect)->movePos(rect,30,-30);
    if (vtable(rect)->getXpos(rect) != 75) return 1;
    if (vtable(rect)->getYpos(rect) != 30) return 1;
    if (vtable(rect)->getArea(rect) != 20000) return 1;

    return 0;
}


