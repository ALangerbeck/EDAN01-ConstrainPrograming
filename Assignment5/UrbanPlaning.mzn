%Urban planing using JaCoP 4.8 
include "globals.mzn";

%== input data ==
int: n;
int: n_commercial;
int: n_residential;
array[1..n+1] of int: point_distribution;

%== decision variabled ==
var 2*n*min(point_distribution)..2*n*max(point_distribution): total_points;

array[1..n,1..n] of var 0..1: placement;
array[1..n] of var 0..n : row_sums;
array[1..n] of var 0..n : column_sums;
array[1..n] of var min(point_distribution)*2..max(point_distribution)*2 : row_points;
array[1..n] of var min(point_distribution)*2..max(point_distribution)*2 : column_points;

%== constraints ==

%constain number of residential/comercial
constraint sum(i in 1..n, j in 1..n)(placement[i,j]) = n_residential; 
constraint n*n - sum(i in 1..n, j in 1..n)(placement[i,j]) = n_commercial;

%make row and column sum of residetial
constraint forall(i in 1..n)(row_sums[i] = sum(j in 1..n)(placement[j,i]));
constraint forall(i in 1..n)(column_sums[i] = sum(j in 1..n)(placement[i,j]));

%translate sum of residetial to points
constraint forall(i in 1..n)(row_points[i] = point_distribution[row_sums[i]+1]);
constraint forall(i in 1..n)(column_points[i] = point_distribution[column_sums[i]+1]);

%finilize points
constraint total_points = sum(i in 1..n)(row_points[i]+column_points[i]);

%destroy symetry
constraint lex2(placement);

solve maximize total_points;

output[
        %"row sum of residential: ",show(row_sums),"\n",
        %"column sum of residential: ",show(column_sums),"\n",
        "placement in ", show(n),"*",show(n)," grid (0 means comercial, 1 means residential) : \n",show2d(placement),"\n",
        "max points: ",show(total_points),"\n"]







