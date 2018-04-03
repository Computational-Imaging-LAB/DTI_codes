#!/bin/bash 
HOST='compimglab.myqnapcloud.com'
USER='ozgecan_kaplan'
PASSWD='guest123'
echo 'This script multiplies the FA / MD map by masks of desired atlas.'

#Download masks from server. 

#Download MNI Atlas masks.
#ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/ /PD_Patients/Atlases/MNI/MNI_on_2mm_Brain/MNI_Masks

#Download JHU 81 DTI Atlas Masks.
#ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/ /PD_Patients/Atlases/JHU_81/JHU_81_Mask


input_dir="/home/compimglab/Desktop/Registration2mm/B0_MNI_TrMatrix"
mask_dir="/home/compimglab/Desktop/Masks2mm"

output_dir='/home/compimglab/Desktop/Masked2mm'
mkdir /home/compimglab/Desktop/Masked2mm/
cd /home/compimglab/Desktop/Masked2mm/

k=(01 02 03 04 05 07 08 09 10 11 12 13 14 15 16 17 18 19);
#p=(03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20 21 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71) ;
#Ani's List 

#k=(19)
p=(15 37 38 43 49 68 69 74)

for pat in "${p[@]}"
do
for ((i=1;i<=57;i++));
do 

fslmaths ${mask_dir}/M${i}_*.nii.gz -mul ${input_dir}/PD${pat}_FA_to_MNI_lin.nii.gz ${output_dir}/PD${pat}_M${i}_FA.nii.gz  

fslmaths ${mask_dir}/M${i}_*.nii.gz -mul ${input_dir}/PD${pat}_MD_to_MNI_lin.nii.gz ${output_dir}/PD${pat}_M${i}_MD.nii.gz  

done
done 



for kon in "${k[@]}"
do
for ((i=1;i<=57;i++));
do 

fslmaths ${mask_dir}/M${i}_*.nii.gz -mul ${input_dir}/K${kon}_FA_to_MNI_lin.nii.gz ${output_dir}/K${kon}_M${i}_FA.nii.gz  

fslmaths ${mask_dir}/M${i}_*.nii.gz -mul ${input_dir}/K${kon}_MD_to_MNI_lin.nii.gz ${output_dir}/K${kon}_M${i}_MD.nii.gz  

done 
done 




