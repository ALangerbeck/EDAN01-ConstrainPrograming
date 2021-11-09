include "globals.mzn";

int: n;
int: n_prefs;
array[1..n_prefs,1..2] of 0..n: prefs;

array[1..n] of var 1..n: position;
array[1..n_prefs] of var int: satisfaction_dist;
var int: maxDistance;

constraint  alldifferent(position);
constraint  forall(i in 1..n_prefs)(satisfaction_dist[i] = abs(position[prefs[i,1]] - position[prefs[i,2]]));
constraint maxDistance = max(satisfaction_dist);


solve minimize maxDistance;

output[
"Order: ", show(position), "\n",
"Maximum distance: ", show(maxDistance), "\n" 
]
%solve satisfy;