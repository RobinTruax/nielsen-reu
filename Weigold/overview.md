# Algorithm Planning
My goal is to optimize the algorithm in order to check Weigold's Conjecture on A_1,...,A_20.
## Operations Required
### Conjugacy Classes
This happens only once and is quick (nearly instant on A_20 using a single core), so no performance optimization or multithreading is necessary at this stage.
 - Relevant: ConjugacyClasses, Representative
### Maximal Subgroups
This happens only once, but takes a long time. A_12 is runnable in a feasible amount of time, but A_13 is not (at least on my laptop). It's probably a good idea to try this in a supercluster. Another option is to implement a faster maximal subgroup algorithm.
 - Relevant: MaximalSubgroups
### Centralizer
This happens a number of times, and is quick but nontrivial each time. This can be parallelized. It is unfortunately faster to compute the centralizer directly than to compute the intersection of the maximal subgroup (even under the NormalIntersection protocol).
 - Relevant: Centralizer
### Pruning \sigma_2
 - Relevant: <, >
### Pruning \sigma_3
 - Relevant: RightTransversal, Subgroup(G, [\sigma_1, \sigma_2])
### Checking 2-Transitivity
 - Relevant: https://conf.math.illinois.edu/Software/GAP-Manual/About_Operations_of_Groups.html
### Checking if Belongs to Tree
### ExploreGraph
