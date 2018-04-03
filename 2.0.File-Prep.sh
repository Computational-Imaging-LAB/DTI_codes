#!/bin/bash 
HOST='compimglab.myqnapcloud.com'
USER='ozgecan_kaplan'
PASSWD='guest123'

echo 'Enter healthy control indexes.'
declare -a input_K
while read line
do
input_K=("${input_K[@]}" $line)
done
echo 'Press Ctrl+D to see your control array & move on.'  
echo ${input_K[@]}
echo 'Enter patient indexes.'

declare -a input_P
while read line
do
input_P=("${input_P[@]}" $line)
done

echo 'Press Ctrl+D to see your Patient array & move on.'  
echo ${input_P[@]}

#input_K=(01 02 03 04 05 07 08 09 10 11 12 13 14 15 16 17 18 19)
#input_P=(03 05 10 12 14 17 18 19 26 27 28 32 33 36 39 40 44 45 47 48 51 52 53 54 55 56 60 61 65 67 70 71
 04 06 07 08 09
 11 13 16 23 24 25 30 31 34 35 41 42 46 50 57 58 59 62 63 64 66)

#wget -r -np -nH -cut-dirs=3 -R index.html --user=$USER --password=$PASSWD $HOST/PD_Patients/K_* /home/compimglab/Desktop/dti/ 
#--no-clobber
#wget -P /home/compimglab/Desktop/dti/ -nd-r --no-parent --reject "index.html" ftp://$USER:$PASSWD@$HOST/PD_Patients/K_*

mkdir /home/compimglab/Desktop/DTI
mkdir /home/compimglab/Desktop/B0
mkdir /home/compimglab/Desktop/T1


####### Healthy Control #############################

for i in "${input_K[@]}"
do
#Get DTI.nii images to DTI folder.  ncftpget, ftp serverdan pathi belirlenmiş dosyayı belirtilen kalsöre indirir. 
 
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/DTI/ /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/*.*

 #Each DTI image is named DTI_32, on our workspace, name is changed by index. 
mv /home/compimglab/Desktop/DTI/DTI_32.nii.gz /home/compimglab/Desktop/DTI/K${i}.nii.gz 
mv /home/compimglab/Desktop/DTI/DTI_32.bval /home/compimglab/Desktop/DTI/K${i}.bval 
mv /home/compimglab/Desktop/DTI/DTI_32.bvec /home/compimglab/Desktop/DTI/K${i}.bvec 

#Get B0.nii images to B0 folder.
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/B0/ /PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/*.*

#Get T1.nii images to T1 folder.
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/T1/ /PD_Patients/K_${i}/exam_1/images/T1/T1/nii/*.*


 #Each DTI image is named DTI_32, on our workspace, name is changed by index. 
mv /home/compimglab/Desktop/B0/DTI_32.nii.gz /home/compimglab/Desktop/B0/K${i}_B0.nii.gz  
mv /home/compimglab/Desktop/T1/T1W_3D_TFE_ref.nii.gz /home/compimglab/Desktop/T1/K${i}_T1.nii.gz  
done

####### END #############################
##### PD-Patients #######################

for i in "${input_P[@]}"
do
#Get DTI.nii images to DTI folder.  
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/DTI/ /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/*.*
 
#Each DTI image is named DTI_32, on our workspace, name is changed by index.
mv /home/compimglab/Desktop/DTI/DTI_32.nii.gz /home/compimglab/Desktop/DTI/PD${i}.nii.gz 
mv /home/compimglab/Desktop/DTI/DTI_32.bval /home/compimglab/Desktop/DTI/PD${i}.bval 
mv /home/compimglab/Desktop/DTI/DTI_32.bvec /home/compimglab/Desktop/DTI/PD${i}.bvec 

#Get B0.nii images to B0 folder.
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/B0/ /PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/B0_DTI_32/nii/*.*

#Get T1.nii images to T1 folder.
ncftpget -T -R -v -u $USER -p $PASSWD $HOST /home/compimglab/Desktop/T1/ /PD_Patients/PD_${i}/exam_1/images/T1/T1/nii/*.*

#Each DTI image is named DTI_32, on our workspace, name is changed by index.
mv /home/compimglab/Desktop/B0/DTI_32.nii.gz /home/compimglab/Desktop/B0/PD${i}_B0.nii.gz  
mv /home/compimglab/Desktop/T1/T1W_3D_TFE_ref.nii.gz /home/compimglab/Desktop/T1/PD${i}_T1.nii.gz  

done

####### END ##########

##### PROCESSING #####

#. ./1.ECC_BET.sh 

echo "Tensor Fitting will start."
#. ./2.TENSOR_FITTING.sh 

#. ./3.Register.sh
 
##### END #####
##### TBSS ####

. ./4.TBSS.sh 



