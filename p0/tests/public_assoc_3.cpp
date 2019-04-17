// A test for AssocList
// The test returns exit code 0 for success and 1 for failure


#include "../AssocList.h"


int main()
{
    AssocList<int, void> lst;

	if (lst.lookup(5) != 0) return 1;
	if (lst.remove(5)) return 1;
	
	return 0;
}


