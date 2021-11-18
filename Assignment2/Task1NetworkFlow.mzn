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

%array of arcs in graph
array[1..n_edges,1..2] of int: arcs = array2d(1..n_edges, 1..2,[
  if j==1 then from[i]
  else to[i] endif
  |i in 1..n_edges,j in 1..2
  ]);

%array of flow balance for each node
array[1..graph_size] of int: balances = [
  if i == start then n_dests
  elseif exists(j in 1..n_dests)(dest[j] == i) then -1
  else 0 endif
  |i in 1..graph_size];
  
%array of flows, domain variables for each arc
array [1..graph_size] of var -n_dests..n_dests: flows;

constraint 
  network_flow(arcs, balances, flows);
  
var int: totalCost = sum([cost[i] | i in 1..n_edges where flows[i] != 0]);

solve minimize totalCost;
 



  
  
  
 