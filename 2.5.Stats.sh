#!/bin/bash

indir="/home/compimglab/Desktop/tbss_files" 

cd ${indir}/MCI_CI_compare/stats/
design_ttest2 design 32 26

randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 5000 --T2

tbss_fill tbss_tfce_corrp_tstat1 0.95 mean_FA tbss_fill

cd ${indir}/MCI_HC_compare/stats/
design_ttest2 design 32 18

randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 5000 --T2

tbss_fill tbss_tfce_corrp_tstat1 0.95 mean_FA tbss_fill

cd ${indir}/CI_HC_compare/stats/
design_ttest2 design 26 18

randomise -i all_FA_skeletonised -o tbss -m mean_FA_skeleton_mask -d design.mat -t design.con -n 5000 --T2

tbss_fill tbss_tfce_corrp_tstat1 0.95 mean_FA tbss_fill


