#!/bin/bash 
 
HOST='compimglab.myqnapcloud.com'
USER='ozgecan_kaplan'
PASSWD='guest123'

echo 'This script applies Eddy Current Correction and Brain Extraction on the input images.'

DTIDir="/home/compimglab/Desktop/DTI/"
B0Dir="/home/compimglab/Desktop/B0/"
T1Dir="/home/compimglab/Desktop/T1/"


##### PD-Patients #######################

for i in "${input_P[@]}"
do 

##1. Eddy Current Correction B0 of each patient & DTI of each patient.
cd /home/compimglab/Desktop/DTI/ 
eddy_correct PD${i} /home/compimglab/Desktop/DTI/PD${i}_ecc 0

cd /home/compimglab/Desktop/B0/
eddy_correct PD${i}_B0 /home/compimglab/Desktop/B0/PD${i}_B0_ecc 0
 

##2. Extract skull & spine for B0 of each patient.
cd /home/compimglab/Desktop/B0/
t=0.2 
bet PD${i}_B0_ecc PD${i}_B0_ecc_brain -m -f $t -g 0 

 #2.1. Multiply DTI & B0_brain_mask of each patient. 
fslmaths "${DTIDir}PD${i}_ecc.nii.gz" -mul "${B0Dir}PD${i}_B0_ecc_brain_mask.nii.gz" "${DTIDir}PD${i}_ecc_brain.nii.gz"  

cd /home/compimglab/Desktop/T1/
t1=0.5 
bet "PD${i}_T1" "PD${i}_T1_brain" -m -f $t1 -g 0 

#Upload Followinf Outputs to Server.  
#PD${i}_ecc.nii.gz
#PD${i}_ecc.ecc.log
#PD${i}_ecc_brain.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}PD${i}_ecc.nii.gz"
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}PD${i}_ecc.ecclog"
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}PD${i}_ecc_brain.nii.gz" 

#PD${i}_B0_ecc.nii.gz
#PD${i}_B0_ecc.ecc.log
#PD${i}_B0_ecc_brain.nii.gz
#PD${i}_B0_ecc_brain_mask.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}PD${i}_B0_ecc.nii.gz"  

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}PD${i}_B0_ecc.ecclog"
 
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}PD${i}_B0_ecc_brain.nii.gz"
  
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}PD${i}_B0_ecc_brain_mask.nii.gz"  

#PD${i}_T1_brain.nii.gz
#PD${i}_T1_brain_mask.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/T1/T1/nii/ "${T1Dir}PD${i}_T1_brain.nii.gz"  

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/PD_${i}/exam_1/images/T1/T1/nii/ "${T1Dir}PD${i}_T1_brain_mask.nii.gz"   

done 


####### Healthy Control #############################

for i in "${input_K[@]}"
do 

##1. Eddy Current Correction B0 of each patient & DTI of each patient.
cd /home/compimglab/Desktop/DTI/ 
eddy_correct K${i} /home/compimglab/Desktop/DTI/K${i}_ecc 0

cd /home/compimglab/Desktop/B0/
eddy_correct K${i}_B0 /home/compimglab/Desktop/B0/K${i}_B0_ecc 0
 

##2. Extract skull & spine for B0 of each patient.
cd /home/compimglab/Desktop/B0/
t=0.2 
bet K${i}_B0_ecc K${i}_B0_ecc_brain -m -f $t -g 0 

 #2.1. Multiply DTI & B0_brain_mask of each patient. 
fslmaths "${DTIDir}K${i}_ecc.nii.gz" -mul "${B0Dir}K${i}_B0_ecc_brain_mask.nii.gz" "${DTIDir}K${i}_ecc_brain.nii.gz"  

cd /home/compimglab/Desktop/T1/
t1=0.5 
bet "K${i}_T1" "K${i}_T1_brain" -m -f $t1 -g 0 

#Upload Following Outputs to Server.  
#K${i}_ecc.nii.gz
#K${i}_ecc.ecc.log
#K${i}_ecc_brain.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}K${i}_ecc.nii.gz"
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}K${i}_ecc.ecclog"
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/ "${DTIDir}K${i}_ecc_brain.nii.gz" 

#K${i}_B0_ecc.nii.gz
#K${i}_B0_ecc.ecc.log
#K${i}_B0_ecc_brain.nii.gz
#K${i}_B0_ecc_brain_mask.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}K${i}_B0_ecc.nii.gz"  

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}K${i}_B0_ecc.ecclog"
 
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}K${i}_B0_ecc_brain.nii.gz"
  
ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/ "${B0Dir}K${i}_B0_ecc_brain_mask.nii.gz"  

#K${i}_T1_brain.nii.gz
#K${i}_T1_brain_mask.nii.gz

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/T1/T1/nii/ "${T1Dir}K${i}_T1_brain.nii.gz"  

ncftpput -u $USER -p $PASSWD $HOST /PD_Patients/K_${i}/exam_1/images/T1/T1/nii/ "${T1Dir}K${i}_T1_brain_mask.nii.gz"   

done 
####### END #############################

echo "Eddy Correction & BET has ended. Next Tensor Fitting will be executed."








