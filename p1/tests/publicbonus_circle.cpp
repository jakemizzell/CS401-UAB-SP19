

#include <iostream>
#include "../ShapesStructs.h"


int main()
{
    void* circ = newCircle(0,0,50);
    vtable(circ)->movePos(circ,25,15);
    vtable(circ)->scaleBy(circ,-2.0);
    vtable(circ)->movePos(circ,-20,-15);
    vtable(circ)->scaleBy(circ,0.75);
    if (vtable(circ)->getXpos(circ) != 5) return 1;
    if (vtable(circ)->getYpos(circ) != 0) return 1;
    double ar = vtable(circ)->getArea(circ);
    double ar1 = 75.0*75.0*3.14159265;
    if (ar != ar1) return 1;
    
    return 0;
}



