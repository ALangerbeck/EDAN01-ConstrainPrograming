include "globals.mzn";

int: beef;
int: bun;
int: chees;
int: onions;
int: pickles;
int: lettuce;
int: ketchup;
int: tomato;

array[1..8] of var 1..5: burger;

array[1..8] of int: sodium;
array[1..8] of int: fat;
array[1..8] of int: calories;
array[1..8] of int: cost;

predicate sumIsLess(array[int] of var int: array1, array[int] of var int: array2, int:sum) =
  array1[1] * array2[1] +  array1[2] * array2[2] +  array1[3] * array2[3] +  array1[4] * array2[4] +  
  array1[5] * array2[5] +  array1[6] * array2[6] +  array1[7] * array2[7] + array1[8] * array2[8] < sum;
  

constraint sumIsLess(burger,sodium,3000);
constraint sumIsLess(burger,fat,150);
constraint sumIsLess(burger,calories,3000);
constraint burger[tomato] = burger[lettuce];
solve maximize burger[1]*cost[1] + burger[2]*cost[2] + burger[3]*cost[3] + burger[4]*cost[4] + burger[5]*cost[5] + burger[6]*cost[6] + burger[7]*cost[7] + burger[8]*cost[8];
