%Assignement 4 diffn model
include "globals.mzn";
include "cumulative.mzn";


int: del_add;
int: del_mul;

int: number_add;
int: number_mul;

int: n;
set of int : last;
set of int:add;
set of int : mul;
var 0..max(del_add,del_mul)*n: end;

set of int: nodes = 1..n;
array[1..n] of set of int: dependencies;

array[1..n] of var 0..max(del_add,del_mul)*n : times;
array[1..n] of var 1..(number_add) : add_res;
array[1..n] of var 1..(number_mul) : mul_res;

array[1..n] of var int: duration = 
[ if x in add then del_add
   else del_mul
   endif  | x in 1..n];
   
%only cumulative
array[1..n] of var int: adders = 
[ if x in add then 1
   else 0
   endif  | x in 1..n];
   
array[1..n] of var int: mults = 
[ if x in add then 0
   else 1
   endif  | x in 1..n];
   
constraint cumulative([times[i]| i in add],[del_add| i in add],[1 | i in add],[number_add| i in add]);
constraint cumulative([times[i]| i in mul],[del_mul| i in mul],[1 | i in mul],[number_mul| i in mul]);
   
constraint diffn([times[i]| i in add], [add_res[i]| i in add],[duration[i] | i in add] ,[1 | i in add]);
constraint diffn([times[i]| i in mul],  [mul_res[i]| i in mul] ,[duration[i] | i in mul],[1 | i in mul]);

constraint forall(i in nodes, j in dependencies[i])(((times[i] + duration[i]) <= times[j]));

constraint forall(o in last)(times[o] + duration[o] <= end);


solve minimize end;

output [ "time = ",show(end)];
