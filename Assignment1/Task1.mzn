include "globals.mzn";

int: n;
int: n_prefs;
array[1..n_prefs,1..2] of 0..n: prefs;

array[1..n] of var 1..n: position;
array[1..n_prefs] of var int: satisfaction_dist;
var int: satisfiedPrefrence;

constraint  alldifferent(position);
constraint position[1] < position[2];
constraint  forall(i in 1..n_prefs)(satisfaction_dist[i] = abs(position[prefs[i,1]] - position[prefs[i,2]]));
constraint satisfiedPrefrence = among(satisfaction_dist,{1});


solve maximize satisfiedPrefrence;

output[
"Order: ", show(position), "\n",
"Number of satisfactions: ", show(satisfiedPrefrence), "\n"
]
%solve satisfy;