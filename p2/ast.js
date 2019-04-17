/*   
 * Project 2 -- ast.js -- convenience functions for building ast nodes in the IMP language. 
 ************************************   
 * 
 * This is not a file you need to change, but look at the tests and see how it is used to   
 * build ASTs for programs in the IMP language. 
 *	 	 
 *************************************** 
 */	 	 

 
exports.n = (n) => ({form: 'n', n: n});	 	 
exports.x = (x) => ({form: 'x', x: x});
exports["+"] = (a0,a1) => ({form: '+', a0: a0, a1: a1});	
exports["-"] = (a0,a1) => ({form: '-', a0: a0, a1: a1}); 
exports['*'] = (a0,a1) => ({form: '*', a0: a0, a1: a1});   
exports['<='] = (a0,a1) => ({form: '<=', a0: a0, a1: a1});   
exports['='] = (a0,a1) => ({form: '=', a0: a0, a1: a1}); 
exports.and = (b0,b1) => ({form: 'and', b0: b0, b1: b1}); 
exports.or = (b0,b1) => ({form: 'or', b0: b0, b1: b1}); 
exports.not = (b) => ({form: 'not', b: b});   
exports.true = () => ({form: 'true'});
exports.false = () => ({form: 'false'});   
exports.skip = () => ({form: 'skip'}); 
exports[";"] = (c0,c1) => ({form: ';', c0: c0, c1: c1}); 
exports[":="] = (x,a) => ({form: ':=', x: x, a: a});	 	 
exports.if = (b,c0,c1) => ({form: 'if', b: b, c0: c0, c1: c1});   
exports.while = (b,c) => ({form: 'while', b: b, c: c}); 
   

