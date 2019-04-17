// A test for AssocList
// The test returns exit code 0 for success and 1 for failure


#include "../AssocList.h"


int main()
{
    AssocList<int, int> list;
    int v = 5;

	list.add(0,&v);
	list.add(1,&v);
	list.add(2,&v);
	list.remove(0);
	if (list.size() != 2) return 1;
	if (!list.remove(2)) return 1;
	if (!list.remove(1)) return 1;
	if (list.remove(1)) return 1;
    if (list.size() != 0) return 1;
	
	return 0;
}

