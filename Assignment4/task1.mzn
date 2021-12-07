%Assignement 4 Must use diffn and cumulative constraint
include "globals.mzn";
include "cumulative.mzn";
include "jacop.mzn";


int: del_add;
int: del_mul;

int: number_add;
int: number_mul;

int: n;
set of int : last;
set of int:add;
set of int : mul;

set of int: nodes = 1..n;

array[1..n] of var 0..max(del_add,del_mul)*n : start_time;
array[1..n] of var 1..(number_add) : add_height;
array[1..n] of var 1..(number_mul) : mul_height;

array[1..number_add] of var 1..n: resource_add;
array[1..number_mul] of var 1..n: resourcemul;

%array[1..n] of var 1..(if number_mul > number_add then number_mul else number_add endif) : r;


var 0..max(del_add,del_mul)*n: end;


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


array[1..n] of set of int: dependencies;

constraint forall(i in nodes, j in dependencies[i])((start_time[i] + duration[i]) <= start_time[j]);


constraint cumulative(start_time,duration,adders,number_add);
constraint cumulative(start_time,duration,mults,number_mul);

constraint diffn([start_time[i]| i in add], [add_height[i]| i in add],[del_add | i in add] ,[1 | i in add]);
constraint diffn([start_time[i]| i in mul],  [mul_height[i]| i in mul] ,[del_mul | i in mul],[1 | i in mul]);

constraint forall(o in last)(start_time[o] + duration[o] <= end);

%constraint resource_add[i] = among(add_height,{i}) | i in 1..number_add;


solve :: seq_search([
         int_search(start_time, smallest_max, indomain_min, complete)])
         minimize end;

output [ "time = ",show(end),"\n",
         "used mults = ",show(mul_height),"\n",
         "used adds = ",show(add_height),"\n"];

