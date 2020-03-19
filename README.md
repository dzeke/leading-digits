# leading-digits
Leading digit analysis for smart water meters

This repository accompanies a forthcoming publication on leading-digit patterns from smart water meters. The scripts process smart meter records and analyze the distribution of their first significant digits.


1. leading-digits-load.R - Script to select and filter raw meter data, then save to CSV
2. leading-digits-analyze.R - Script to analyze leading digits (Benford's law, power law, etc.)
3. ks-crit-values.csv - Table of critical Kolmogorov-Smirnov values for sample size up to 744
