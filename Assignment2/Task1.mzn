% Task 1
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


%Constraint
  forall(destinaion in 1..n_dest, city in 1..graphsize)(
    nextDest[Destination,city] =
      {to[x] | x in 1..n_edges where (from[x] == city)}
      union
      {from[x] | x in 1..n_edges where (to[x] == city}
  );