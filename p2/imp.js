/*   
 * Project 2 -- imp.js -- interp_A, interp_B, interp_C funcitons that model taking a step
 *                        in the big-step semantics for IMP shown in slides. (For 401 and 501.)	 	 
 ************************************
 *	 	 
 * Your job is to finish the three functions below that model the derivation step   
 * (in our big-step semantics from the slides in class) of the =>_A, =>_B, and =>_C	 	 
 * step functions. interp_A takes an arithmetic expression, like {form: 'x', x: 'z'},	 	 
 * and a state/store, like (x) => {if (x == 'z') return 7;}, and yields a number, like 7. 
 * interp_B takes a boolean expression and a store to a boolean, and interp_C takes a	 	 
 * command and a store to a new store (i.e., the program state, a model of the heap). Note
 * that the current store is a javascript function that should take some variable 
 * (program location) and yield its current value in the store. (Note the definition of   
 * sigma[x \mapsto n] in the slides.) See ast.js for a definition of some convenience	 	 
 * functions for producing an AST that define the different language forms as JSON objects.   
 *
 ***************************************	
 */


exports.interp_A = interp_A;	 	 
exports.interp_B = interp_B;	 	 
exports.interp_C = interp_C; 

	 	 
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

 
function interp_A(a, store)   
{ 
    // store should be a function that takes a variable name, like 'x', and returns its value
    if (a.form == 'x') 
	   return store(a.x);	

    // a number is just the constant stored in the AST node      
    else if (a.form == 'n')
	   return a.n;

    // A sum AST node is interpreted as the sum of the interpretations of each sub-expression
    else if (a.form == '+')   
	   return interp_A(a.a0, store) + interp_A(a.a1, store); 

    // TODO: Add interpretations for '*' and '-' expressions
    else if (a.form == "-")
        return interp_A(a.a0, store) - interp_A(a.a1, store);

    else if (a.form == "*")
        return interp_A(a.a0, store) * interp_A(a.a1, store);

    //DONE	
    console.log(`failed to interpret: ${a} \nwith store: ${store}`);
}	 	 

function interp_B(b, store) 
{ 
    // TODO: What other boolean expressions need to be handled in this function?
    if (b.form == 'not') 
	   return !interp_B(b.b, store);

    else if (b.form == 'true')	 	 
	   return true;

    //TODO Start
    else if (b.form == 'false')
        return false;

    else if (b.form == '<=') 
        return interp_A(b.a0,store) <= interp_A(b.a1,store);

    else if (b.form == '=') 
         return interp_A(b.a0,store) == interp_A(b.a1,store);

    else if (b.form == 'and')
        return interp_B(b.b0,store) && interp_B(b.b1,store);

    else if (b.form == 'or') 
        return interp_B(b.b0,store) || interp_B(b.b1,store);

    //DONE
    console.log(`failed to interpret: ${b} \nwith store: ${store}`);   

    //When you call interp_B(b.bX,store) it returns true or false 
    //so you can just return interp_B(b.bX,store)
}   

function interp_C(c, store)
{   
    if (c.form == 'skip')	 	 
	   return store;	

    // TODO: What other commands need to handled in this function?
    else if (c.form == ';')
        return interp_C(c.c1,interp_C(c.c0,store));

    else if (c.form == ':=')
        return y => y == c.x ? interp_A(c.a,store) : store(y);

    else if (c.form == 'if')
        return interp_B(c.b,store) ? interp_C(c.c0,store) : interp_C(c.c1,store);

    else if (c.form == 'while')
        return interp_B(c.b,store) ? interp_C(c,interp_C(c.c,store)) : store;

    //DONE
    console.log(`failed to interpret: ${c} \nwith store: ${store}`);	
} 