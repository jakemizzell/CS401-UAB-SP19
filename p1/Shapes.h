/*   
 * Project 1 -- Shapes class hierarchy 
 ************************************ 
 * 
 * You do not need to modify this file, but you 
 * should read over it carefully before starting.	 	 
 * You must write ShapesStructs.h, manually constructing	 	 
 * vtables for the class hierarchy in this file.	 	 
 *   
 ***************************************	 	 
 */	 	 


#pragma once	 	 


// This is an interface for our three Shape classes below	
class IShape 
{   
public:	
    virtual double getArea() const = 0; 

    virtual double getXpos() const = 0; 

    virtual double getYpos() const = 0;	 	 

    virtual void scaleBy(double factor) = 0;	 	 

    virtual void movePos(double dx, double dy) = 0; 
};	 	 


// This is a class for circles, satisfying interface IShape	 	 
class Circle	 	 
    : public IShape   
{	 	 
private:	 	 
    double x, y, r;	 	 

public:   
    Circle(double x0, double y0, double r0)	 	 
        : x(x0), y(y0), r(r0)	 	 
    {   
        if (r < 0) r = -r;	 	 
    }

    virtual double getArea() const   
    {	 	 
        return 3.14159265 * this->r * this->r;   
    } 

    virtual double getXpos() const
    {	
        return this->x;   
    } 

    virtual double getYpos() const	 	 
    {	 	 
        return this->y;	 	 
    }   

    virtual void scaleBy(double factor)
    {   
        this->r *= factor;	 	 
        if (this->r < 0) this->r = -this->r;
    } 

    virtual void movePos(double dx, double dy) 
    {	 	 
        this->x += dx; 
        this->y += dy;	 	 
    }   
};	 	 


// This is a class for rectangles, satisfying interface IShape   
class Rectangle 
    : public IShape	 	 
{   
private:	 	 
    double left, right, top, bottom;

public:	
    Rectangle(double x0, double y0, double x1, double y1)   
    {	 	 
        if (x0 < x1)   
        { 
            this->left = x0;	
            this->right = x1;	 	 
        }	
        else 
        {   
            this->left = x1; 
            this->right = x0;   
        }   
        if (y0 < y1) 
        {
            this->bottom = y0; 
            this->top = y1;   
        }   
        else   
        { 
            this->bottom = y1;   
            this->top = y0; 
        }
    }	 	 

    virtual double getArea() const
    {	 	 
        return (this->top - this->bottom) * (this->right - this->left);   
    }   

    virtual double getXpos() const   
    {
        return (this->left + this->right)/2.0;   
    }   

    virtual double getYpos() const 
    {   
        return (this->top + this->bottom)/2.0;   
    }

    virtual void scaleBy(double factor)
    {	 	 
        double xc = this->getXpos();   
        double yc = this->getYpos();
        this->left = xc - (xc - this->left)*factor;   
        this->right = xc + (this->right - xc)*factor;
        this->bottom = yc - (yc - this->bottom)*factor;   
        this->top = yc + (this->top - yc)*factor;	 	 
    } 

    virtual void movePos(double dx, double dy) 
    {	 	 
        this->top += dy;	 	 
        this->bottom += dy;   
        this->right += dx;	 	 
        this->left += dx;
    }	 	 
}; 

	 	 

