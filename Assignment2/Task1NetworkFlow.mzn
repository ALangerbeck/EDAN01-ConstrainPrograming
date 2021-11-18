% Task 1 NetworkFlow
include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
array[0..n_dests] of var int: dest;
int: n_edges;
array[0..n_edges] of var int:from;
array[0..n_edges] of var int:to;
array[0..n_edges] of var int:cost;

%Decision Variables
var int: travelCost;
array[1..n_dests,1..graph_size] of var set of int: nextDest;
array[1..n_dests,1..graph_size] of var 0..20: pathCost;



  
  
  
 