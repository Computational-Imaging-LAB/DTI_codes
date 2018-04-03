#!/bin/bash 
#Register B0 brain to MNI brain 
declare -a MCI
declare -a CI 
declare -a HC 

#MCI=(03 05 10 12 14 17 18 19 26 27 28 32 33 36 39 40 44 45 47 48 51 52 53 54 55 56 60 61 65 67 70 71) 
MCI=(56) 
#20 21 29 non lin olmadı.
CI=(04 06 07 08 09 11 13 16 23 24 25 30 31 34 35 41 42 46 50 57 58 59 62 63 64 66) 
HC=(01 02 03 04 05 07 08 09 10 11 12 13 14 15 16 17 18 19) 

KBrainDir="/home/compimglab/Desktop/DTI_Thesis/" 
BVecDir="/home/compimglab/Desktop/DTI_Thesis/"
BValDir="/home/compimglab/Desktop/DTI_Thesis/"
B0Dir="/home/compimglab/Desktop/B0_Thesis/"
MNIDir="/usr/share/fsl/5.0/data/standard/MNI152_T1_2mm_brain.nii.gz"
OutDir="/home/compimglab/Desktop/Registration2mm/B0_MNI_TrMatrix/"
FnirtDir="/home/compimglab/Desktop/Registration2mm/Fnirt/"

for i in "${MCI[@]}"
do 
FitDir="/home/compimglab/Desktop/DTI_Thesis/PD${i}Fit/"
flirt -in "${B0Dir}PD${i}_B0_ecc_brain.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_B0toMNI.nii.gz" -omat "${OutDir}PD${i}_B0toMNI.mat" -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear 

flirt -in "${FitDir}PD${i}_fit_FA.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_FA_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}PD${i}_B0toMNI.mat" -interp trilinear
echo "PD${i} FA Done"

flirt -in "${FitDir}PD${i}_fit_MD.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_MD_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}PD${i}_B0toMNI.mat" -interp trilinear
echo "PD${i} MD Done"

done

for i in "${CI[@]}"
do 
FitDir="/home/compimglab/Desktop/DTI_Thesis/PD${i}Fit/"
flirt -in "${B0Dir}PD${i}_B0_ecc_brain.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_B0toMNI.nii.gz" -omat "${OutDir}PD${i}_B0toMNI.mat" -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear 

flirt -in "${FitDir}PD${i}_fit_FA.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_FA_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}PD${i}_B0toMNI.mat" -interp trilinear
echo "PD${i} FA Done"

flirt -in "${FitDir}PD${i}_fit_MD.nii.gz" -ref "${MNIDir}" -out "${OutDir}PD${i}_MD_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}PD${i}_B0toMNI.mat" -interp trilinear

echo "PD${i} MD Done"

done

for i in "${HC[@]}"
do 
FitDir="/home/compimglab/Desktop/DTI_Thesis/K${i}Fit/"
flirt -in "${B0Dir}K${i}_B0_ecc_brain.nii.gz" -ref "${MNIDir}" -out "${OutDir}K${i}_B0toMNI.nii.gz" -omat "${OutDir}K${i}_B0toMNI.mat" -bins 256 -cost corratio -searchrx -90 90 -searchry -90 90 -searchrz -90 90 -dof 12  -interp trilinear 

flirt -in "${FitDir}K${i}_fit_FA.nii.gz" -ref "${MNIDir}" -out "${OutDir}K${i}_FA_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}K${i}_B0toMNI.mat" -interp trilinear
echo "HC ${i} FA Done"

flirt -in "${FitDir}K${i}_fit_MD.nii.gz" -ref "${MNIDir}" -out "${OutDir}K${i}_MD_to_MNI_lin.nii.gz" -applyxfm -init "${OutDir}K${i}_B0toMNI.mat" -interp trilinear
echo "HC ${i} MD Done"

done
##




