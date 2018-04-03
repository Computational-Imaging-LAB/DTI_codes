#!/bin/bash 
 
HOST='compimglab.myqnapcloud.com'
USER='ozgecan_kaplan'
PASSWD='guest123'

echo 'This script fits the tensors.Outputs will be saved under the subjects DTI/nii'

KBrainDir="/home/compimglab/Desktop/DTI/" 
BVecDir="/home/compimglab/Desktop/DTI_Thesis/"
BValDir="/home/compimglab/Desktop/DTI_Thesis/"
MaskDir="/home/compimglab/Desktop/B0_Thesis/"
##### PD-Patients #######################

for i in "${input_P[@]}"
do 
echo "Fit Tensors for Image PD_${i}" 

mkdir "/home/compimglab/Desktop/DTI/PD${i}Fit"
OutDir="/home/compimglab/Desktop/DTI/PD${i}Fit/"

dtifit --data="${KBrainDir}PD${i}_ecc_brain.nii.gz" --out="${OutDir}PD${i}_fit" --mask="${MaskDir}PD${i}_B0_ecc_brain_mask.nii.gz" --bvecs="${BVecDir}PD${i}.bvec" --bvals="${BValDir}PD${i}.bval" 


cd /home/compimglab/Desktop/DTI/
ncftpput -R -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/ /home/compimglab/Desktop/DTI/PD${i}Fit/   

done 

####### END ############################
####### Healthy Control #############################

for i in "${input_K[@]}"
do 
echo "Fit Tensors for Image K_${i}"

mkdir "/home/compimglab/Desktop/DTI/K${i}Fit"
OutDir="/home/compimglab/Desktop/DTI/K${i}Fit/"

dtifit --data="${KBrainDir}K${i}_ecc_brain.nii.gz" --out="${OutDir}K${i}_fit" --mask="${MaskDir}K${i}_B0_ecc_brain_mask.nii.gz" --bvecs="${BVecDir}K${i}.bvec" --bvals="${BValDir}K${i}.bval" 

#Upload the outputs to server under regarding patients DTI_32/nii folder. 
cd /home/compimglab/Desktop/DTI/
ncftpput -R -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/ /home/compimglab/Desktop/DTI/K${i}Fit/   

done 

####### END #############################



echo "Eddy Current Correction and Brain Extraction Completed."
echo "Registration will start."








