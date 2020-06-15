# leading-digits
Musings on Leading Digits for Water Use

This repository forks a repository by Sowby (2020) - https://github.com/rsowby/leading-digits and explores the ideas related to leading digits of water use data. Specifically does
the leading (first non-zero) digits principle (1's are more common in data sets) apply to:
   - Smart water meter data for some commercial and industrial water users in Logan, Utah
   - Some common random distributions of data
   
For more information about leading digits and water use and their claims, see Sowby, R. B. (2018). “Conformance of Public Water Use Data to Benford’s Law.” Journal - AWWA, 110(12), E52-E59. https://awwa.onlinelibrary.wiley.com/doi/abs/10.1002/awwa.1161.

## Original files from Sowby:
1. leading-digits-load.R - Script to select and filter raw meter data, then save to CSV
2. leading-digits-analyze.R - Script to analyze leading digits (Benford's law, power law, etc.)
3. ks-crit-values.csv - Table of critical Kolmogorov-Smirnov values for sample size up to 744

## New files added by Rosenberg
4. Dataset2.csv and Dataset3.csv : Some smart water meter data for a commercial water user from Logan, Utah. See Attallah (2019) and (2020) for more info.
5. leading-digits-load_DER.R and leading-digits-analyze-DER.R : Modifications to load the Logan commercial data
6. leading-digits-random-knit.RMD : knitter file to generate histograms of leading digits for common random distributions
7. leading-digits-random-knit.docx: Microsoft word doc with output plots of the knitter file

## References
1. Attaallah, N. A. M. (2018). "Demand Disaggregation for Non-Residential Water Users in the City of Logan, Utah, USA," Utah State University, Logan, Utah. https://digitalcommons.usu.edu/etd/7401.
1. Atallah, N., D. E. Rosenberg (2020). Water Demand Disaggregation for Non-Residential Users of the City of Logan, HydroShare, http://www.hydroshare.org/resource/2081d6098f3e4569bce119174a78f10e