%Assignement 4 Must use diffn and cumulative constraint
include "globals.mzn";


int: del_add;
int: del_mul;

int: number_add;
int: number_mul;

int: n;
set of int : last;
set of int:add;
set of int : mul;

array[1..n] of var int: duration = 
[ if x in add then del_add
   else del_mul
   endif  | x in 1..n];
   
array[1..n] of var int: adders = 
[ if x in add then 1
   else 0
   endif  | x in 1..n];
   
array[1..n] of var int: mults = 
[ if x in add then 0
   else 1
   endif  | x in 1..n];



array[1..28] of set of int: dependencies;