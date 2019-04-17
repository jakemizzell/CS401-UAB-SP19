/*	 	 
 * Project 1 -- Shapes classes manually compiled to structs (CS 501 only, or bonus for 401)   
 ************************************ 
 *
 * In this file, you should write a version of the class hierarchy in 
 * Shapes.h, compiled manually to structs (as we discuss in class)   
 * Your job is to finish the implementation of Circle started below and 
 * write an implementation for class Rectangle. Use the stubbed out code   
 * below and the tests provided as a guide.   
 *	 	 
 ***************************************
 */   

	 	 
#pragma once	 	 


/************************************ 
 * Honor pledge (please write your name.)	 	 
 *
 * I Jake Mizzell have completed this code myself, without   
 * unauthorized assistance, and have followed the academic honor code.   
 *   
 * Edit the code below to complete your solution. 
 *   
 ***************************************	 	 
 */	


struct ShapeVTable	 	 
{ 
    double (*getArea)(const void*);	 	 
    double (*getXpos)(const void*);	 	 
    double (*getYpos)(const void*); 
    void (*scaleBy)(void*, double);
    void (*movePos)(void*, double, double);   

    ShapeVTable(double (*getArea)(const void*),	 	 
                double (*getXpos)(const void*), 
                double (*getYpos)(const void*),   
                void (*scaleBy)(void*, double),
                void (*movePos)(void*, double, double))   
        : getArea(getArea), getXpos(getXpos), getYpos(getYpos), scaleBy(scaleBy), movePos(movePos)   
    {
    }	 	 
};   

// A function for getting the vtable pointer 
// of a class-as-a-struct with the proper data layout   
ShapeVTable* vtable(void* obj)	
{ 
    return ((ShapeVTable*)((void**)obj)[0]);	 	 
}	 	 


/* Circle (implemented with structs)   
***************************************/   

struct Circle 
{   
    ShapeVTable* vtableptr; 
    double x, y, r;	 	 
}; 
	 	 
// Circle's virtual methods 
// Note that the receiver object is now an explicit parameter "_ths"
double getAreaCircle(const void* _ths)
{
    const Circle* const ths = (const Circle*)_ths;   
    return 3.14159265 * ths->r * ths->r;   
}	

double getXposCircle(const void* _ths)	 	 
{	
    const Circle* const ths = (const Circle*)_ths;	 	 
    return ths->x;	 	 
}   

double getYposCircle(const void* _ths) 
{ 
    const Circle* const ths = (const Circle*)_ths;
    return ths->y; 
}	 	 

void scaleByCircle(void* _ths, double factor) 
{
    Circle* const ths = (Circle*)_ths;	 	 
    // TODO: finish implementing this method
    ths->r *= factor;
    if (ths->r < 0) ths->r = -ths->r;
}	 	 

void movePosCircle(void* _ths, double dx, double dy) 
{ 
    Circle* const ths = (Circle*)_ths;
    ths->x += dx;	 	 
    ths->y += dy;   
}	

// Global vtable for rectangles with the appropriate methods	 	 
ShapeVTable circle_vtable(&getAreaCircle, &getXposCircle,
                             &getYposCircle, &scaleByCircle, 
                             &movePosCircle);
	 	 
// A constructor for rectangles 
Circle* newCircle(double x0, double y0, double r0)	
{ 
    // Can't use reserved id "this", so we'll use "ths"
    Circle* ths = new Circle();   
    ths->vtableptr = &circle_vtable;	 	 
    // Allocate the struct and setup its vtable, then
    // Run the constructor:	 	 
    ths->x = x0; 
    ths->y = y0;	
    ths->r = r0;	 	 
    if (ths->r < 0) ths->r = -ths->r;
    // ...and return the new object:	 	 
    return ths; 
} 


/* Rectangle (implemented as a struct) 
************************************/   

struct Rectangle 
{ 
    ShapeVTable* vtableptr; 
    double left, right, top, bottom;
};	 	 

// TODO: finish implementing the Rectangle class as a struct (as with Circle above)
//       with an explicit vtable   
double getAreaRectangle(const void* _ths)
{
    const Rectangle* const ths = (const Rectangle*)_ths;
    return (ths->top - ths->bottom) * (ths->right - ths->left);   
}

double getXposRectangle(const void* _ths)       
{   
    const Rectangle* const ths = (const Rectangle*)_ths;   
    return (ths->left + ths->right)/2.0;       
}   

double getYposRectangle(const void* _ths) 
{ 
    const Rectangle* const ths = (const Rectangle*)_ths;
    return (ths->top + ths->bottom)/2.0;  
}        

void scaleByRectangle(void* _ths, double factor) 
{
    Rectangle* const ths = (Rectangle*)_ths;  

    double xc = getXposRectangle(ths);
    double yc = getYposRectangle(ths);     
    ths->left = xc - (xc - ths->left)*factor;   
    ths->right = xc + (ths->right - xc)*factor;
    ths->bottom = yc - (yc - ths->bottom)*factor;   
    ths->top = yc + (ths->top - yc)*factor;
}        

void movePosRectangle(void* _ths, double dx, double dy) 
{ 
    Rectangle* const ths = (Rectangle*)_ths;
    ths->left += dx; 
    ths->right += dx;       
    ths->top += dy;   
    ths->bottom += dy;   

}

ShapeVTable rectangle_vtable(&getAreaRectangle, &getXposRectangle,
                             &getYposRectangle, &scaleByRectangle, 
                             &movePosRectangle);

Rectangle* newRectangle(double x0, double y0, double x1, double y1)  
{ 
    // Can't use reserved id "this", so we'll use "ths"
    Rectangle* ths = new Rectangle();   
    ths->vtableptr = &rectangle_vtable;         
    // Allocate the struct and setup its vtable, then
    // Run the constructor:      
    if (x0 < x1)   
        { 
            ths->left = x0;    
            ths->right = x1;        
        }   
        else 
        {   
            ths->left = x1; 
            ths->right = x0;   
        }   
        if (y0 < y1) 
        {
            ths->bottom = y0; 
            ths->top = y1;   
        }   
        else   
        { 
            ths->bottom = y1;   
            ths->top = y0; 
        }     
    // ...and return the new object:         
    return ths; 
} 