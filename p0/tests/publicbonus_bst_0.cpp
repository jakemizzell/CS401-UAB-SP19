// A test for BinaryTree
// The test returns exit code 0 for success and 1 for failure


#include "../BinaryTree.h"


int main()
{
    BinaryTree<int, int> bst;

	int buff[10];
	for (int i = 0; i < 10; ++i)
	{
		buff[i] = i*i*i;
        bst.add(i,&buff[i]);
	}

	if (bst.lookup(4) != &buff[4])
        return 1;

	if (bst.lookup(7) != &buff[7])
        return 1;

	if (bst.lookup(0) != &buff[0])
        return 1;

	return 0;
}


