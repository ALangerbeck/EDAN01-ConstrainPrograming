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

var 0..max(del_add,del_mul)*n: end;


array[1..n] of int: duration = 
[ if x in add then del_add
   else del_mul
   endif  | x in 1..n];
   
array[1..n] of int: adders = 
[ if x in add then 1
   else 0
   endif  | x in 1..n];
   
array[1..n] of int: mults = 
[ if x in add then 0
   else 1
   endif  | x in 1..n];

int : mul_ops = count(mults,1);
int : add_ops = count(adders,1);

array[1..n] of var 0..max(del_add,del_mul)*n : start_time;
array[1..add_ops] of var 1..(number_add) : add_height;
array[1..mul_ops] of var 1..(number_mul) : mul_height;

array[1..number_add] of var 1..n: resource_add;
array[1..number_mul] of var 1..n: resource_mul;

array[1..n] of set of int: dependencies;

constraint forall(i in 1..n, j in dependencies[i])((start_time[i] + duration[i]) <= start_time[j]);


constraint cumulative([start_time[i]|i in add],[del_add | i in add],[1 |i in add],number_add);
constraint cumulative([start_time[i] |i in mul],[del_mul | i in mul],[1 | i in mul],number_mul);



constraint diffn([start_time[i]| i in add], add_height,[del_add | i in add] ,[1 | i in add]);
constraint diffn([start_time[i]| i in mul], mul_height ,[del_mul | i in mul],[1 | i in mul]);

constraint forall(o in last)(start_time[o] + duration[o] <= end);

constraint forall(i in 1..number_add)(resource_add[i] = count(add_height,i));
constraint forall(i in 1..number_mul)(resource_mul[i] = count(mul_height,i));

solve :: 
         int_search(start_time, smallest_max, indomain_min, complete)
         minimize end;

output [ "time = ",show(end),"\n",
        "mul_ops = ",show(mul_height),"\n",
        "mul_resources = ",show(resource_mul),"\n",
        "mults = ",show(mul_ops),"\n",
        "add_ops = ",show(add_height),"\n",
        "add_resources = ",show(resource_add),"\n",
         "adds = ",show(add_ops),"\n",
         ];