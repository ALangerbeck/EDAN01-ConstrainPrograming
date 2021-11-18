% Task 1 NetworkFlow
include "globals.mzn";

int: graph_size;
int: start;
int: n_dests;
array[1..n_dests] of int: dest;
int: n_edges;
array[1..n_edges] of int:from;
array[1..n_edges] of int:to;
array[1..n_edges] of int:cost;

%Decision Variables

%array of arcs in graph, generating a 2d array in which one row is from and one is to
array[1..n_edges,1..2] of int: arcs = array2d(1..n_edges, 1..2,[
  if j == 1 then from[i]
  else to[i] endif
  |i in 1..n_edges,j in 1..2]);

%array of flow balance for each node, set balance in start to number of destinations, and for each destination to -1
array[1..graph_size] of int: balances = [
  if i == start then n_dests
  elseif exists(j in 1..n_dests)(dest[j] == i) then -1
  else 0 endif
  |i in 1..graph_size];
  
%array of flows, domain variables for each arc, set the capacity of each edge
array[1..n_edges] of var -n_dests..n_dests: flows;

constraint network_flow(arcs, balances, flows);

%the flow is now the flows on each arc in the solution so we count number of arcs with flow and sum their costs.
var int: totalCost = sum([cost[i] | i in 1..n_edges where flows[i] != 0]);

solve minimize totalCost;

output[
"cost: ",show(totalCost),"\n"
]
 



  
  
  
 