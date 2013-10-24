DetectAssocations
=================

Detect associations between pairs of variables using Maximal Information content (MIC). Can be parallelized using Hadoop

Maximal Information Content (MIC)
=================================
See the paper by Reshef et al (http://www.sciencemag.org/content/334/6062/1518.abstract, Science 16 December 2011: Vol. 334 no. 6062 pp. 1518-1524, DOI: 10.1126/science.1205438)

MIC is a grahpical algorithm that uses a grid to try to encapsulate the data, then analyze the results using a technique realted to Shannon entropy to determine if a pair of variables are related.


Over-Corelation
===============
The goal of this work is to rapidly search for correlations between large numbers of variables. The danger is that, as you look at potentially massive numbers of variable pairs, you may find an "accidental" correlation. It is worth while discussing how to reduce the likelihood of such false positives.

Bonferroni spent some time considering the problem, and came up with a solution. (http://en.wikipedia.org/wiki/Bonferroni_correction has a good treatment)

The Bonferrone technique can be easily explained by example. If you are looking for significance of S, and doing N searches through the data, then you should look for significance S/N. For example,

If you want significance 0.05 (95% confidence, S=0.05)
... and you are looking at 10 different combinations (N=10)
--- You should consider results significant only when the correlation > S/N, or 0.05/10, or 0.005

By setting the bar higher, you avoid accidental correlations. The Holm-Bonferroni method is considered somewhat more powerful, and you can read about it here  (http://en.wikipedia.org/wiki/Holm%E2%80%93Bonferroni_method)

