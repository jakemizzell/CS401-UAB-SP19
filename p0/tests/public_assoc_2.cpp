// A test for AssocList
// The test returns exit code 0 for success and 1 for failure


#include "../AssocList.h"


void addstufftomap(IMap<int,void>& mp)
{
	// Adds a key for each odd number [3,99]
	// mapped to a void pointer of the same value
    for (int i = 3; i < 100; i += 2)
		mp.add(i,(void*)(unsigned long long)i);
}


int main()
{
    AssocList<int, void> lst;

	addstufftomap(lst);
	if (!lst.remove(67)) return 1;
	if (lst.remove(66)) return 1;
	if (lst.size() != 48) return 1;
    if (lst.lookup(55) != (void*)55) return 1;
	
	return 0;
}


