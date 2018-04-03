#!/bin/bash 

HOST='compimglab.myqnapcloud.com'
DTIDir="/home/compimglab/Desktop/DTI/"
USER='ozgecan_kaplan'
PASSWD='guest123'

#mkdir /home/compimglab/Desktop/tbss_files
indir="/home/compimglab/Desktop/tbss_files/FA"
outdir="/home/compimglab/Desktop/tbss_files" 
RegDir="/home/compimglab/Desktop/Registration"

#1.Copy all FA to another file ignoring the group they belong to.

for i in "${input_K[@]}"
do
##Use the following to get data from server.
#ncftpget -u $USER -p $PASSWD $HOST "/PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/K${i}_FA.nii.gz" "${indir}/K${i}_FA.nii.gz" 

## OR Use the following to process existing file on the PC.(FA MD Maps on your PC)
cp "${RegDir}/K${i}_FA.nii.gz" "${outdir}/K${i}.nii.gz"
done

for i in "${input_P[@]}"
do
#ncftpget -u $USER -p $PASSWD $HOST "/PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/PD${i}_FA.nii.gz" "${indir}/PD${i}_FA.nii.gz"

##Use the following to process existing file on the PC.(FA MD Maps on your PC)
cp "${RegDir}/PD${i}_FA.nii.gz" "${outdir}/PD${i}.nii.gz"
done 


#2.TBSS 
cd ${outdir}
echo "tbss_1"
tbss_1_preproc *.nii.gz  #for all FA maps; 
echo "tbss_2"
tbss_2_reg -T  # -t for specified target; now it`s using FMRIB58_FA_1mm
echo "Done"

echo "Create skeleton mean FA for all images. Move on with tbss3 & 4." 
echo "tbss_3_postreg 3 Groups"
#tbss_3_postreg -T 

echo "tbss_4_prestats"
#tbss_4_prestats 0.2 
echo "Done"

#-----------------------------Dual Comparison File Formation------------------#

declare -a MCI
declare -a HC
declare -a CI 

#Pre-determined data set.

MCI=(03 05 10 12 14 17 18 19 26 27 28 32 33 36 39 40 44 45 47 48 51 52 53 54 55 56 60 61 65 67 70 71) 
CI=(04 06 07 08 09 11 13 16 23 24 25 30 31 34 35 41 42 46 50 57 58 59 62 63 64 66) 
HC=(01 02 03 04 05 07 08 09 10 11 12 13 14 15 16 17 18 19)  



#-----------MCI-CI Files---------------#
mkdir ${outdir}/MCI_CI_compare
mkdir ${outdir}/MCI_CI_compare/FA

for i in ${MCI[*]} 
do 
cp  ${indir}/PD${i}_FA.nii.gz  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_mask.nii.gz ${outdir}/MCI_CI_compare/FA 
cp  ${indir}/PD${i}_FA_to_target.log  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target.mat ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.msf  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.nii.gz  ${outdir}/MCI_CI_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/MCI_CI_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/MCI_CI_compare/FA
cp -r ${outdir}/origdata ${outdir}/MCI_CI_compare/
done

for i in ${CI[*]}
do 
cp  ${indir}/PD${i}_FA.nii.gz  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_mask.nii.gz ${outdir}/MCI_CI_compare/FA 
cp  ${indir}/PD${i}_FA_to_target.log  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target.mat ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.msf  ${outdir}/MCI_CI_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.nii.gz  ${outdir}/MCI_CI_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/MCI_CI_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/MCI_CI_compare/FA
cp -r ${outdir}/origdata ${outdir}/MCI_CI_compare/
done 

#-----------MCI-HC Files---------------#
mkdir ${outdir}/MCI_HC_compare
mkdir ${outdir}/MCI_HC_compare/FA

for i in ${MCI[*]} 
do 
cp  ${indir}/PD${i}_FA.nii.gz  ${outdir}/MCI_HC_compare/FA
cp  ${indir}/PD${i}_FA_mask.nii.gz ${outdir}/MCI_HC_compare/FA 
cp  ${indir}/PD${i}_FA_to_target.log  ${outdir}/MCI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target.mat ${outdir}/MCI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.msf  ${outdir}/MCI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.nii.gz  ${outdir}/MCI_HC_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/MCI_HC_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/MCI_HC_compare/FA
cp -r ${outdir}/origdata ${outdir}/MCI_HC_compare/
done

for i in ${HC[*]}
do 
cp  ${indir}/K${i}_FA.nii.gz  ${outdir}/MCI_HC_compare/FA
cp  ${indir}/K${i}_FA_mask.nii.gz ${outdir}/MCI_HC_compare/FA 
cp  ${indir}/K${i}_FA_to_target.log  ${outdir}/MCI_HC_compare/FA7
cp  ${indir}/K${i}_FA_to_target.mat ${outdir}/MCI_HC_compare/FA
cp  ${indir}/K${i}_FA_to_target_warp.msf  ${outdir}/MCI_HC_compare/FA
cp  ${indir}/K${i}_FA_to_target_warp.nii.gz  ${outdir}/MCI_HC_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/MCI_HC_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/MCI_HC_compare/FA
cp -r ${outdir}/origdata ${outdir}/MCI_HC_compare/
done 

#-----------CI-HC Files---------------#
mkdir ${outdir}/CI_HC_compare
mkdir ${outdir}/CI_HC_compare/FA
for i in ${CI[*]}
do 
cp  ${indir}/PD${i}_FA.nii.gz  ${outdir}/CI_HC_compare/FA
cp  ${indir}/PD${i}_FA_mask.nii.gz ${outdir}/CI_HC_compare/FA 
cp  ${indir}/PD${i}_FA_to_target.log  ${outdir}/CI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target.mat ${outdir}/CI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.msf  ${outdir}/CI_HC_compare/FA
cp  ${indir}/PD${i}_FA_to_target_warp.nii.gz  ${outdir}/CI_HC_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/CI_HC_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/CI_HC_compare/FA
cp -r ${outdir}/origdata ${outdir}/CI_HC_compare/
done 
for i in ${HC[*]}
do 
cp  ${indir}/K${i}_FA.nii.gz  ${outdir}/CI_HC_compare/FA
cp  ${indir}/K${i}_FA_mask.nii.gz ${outdir}/CI_HC_compare/FA 
cp  ${indir}/K${i}_FA_to_target.log  ${outdir}/CI_HC_compare/FA
cp  ${indir}/K${i}_FA_to_target.mat ${outdir}/CI_HC_compare/FA
cp  ${indir}/K${i}_FA_to_target_warp.msf  ${outdir}/CI_HC_compare/FA
cp  ${indir}/K${i}_FA_to_target_warp.nii.gz  ${outdir}/CI_HC_compare/FA 
cp  ${indir}/target.nii.gz ${outdir}/CI_HC_compare/FA 
cp -r ${indir}/tbss_logs ${outdir}/CI_HC_compare/FA
cp -r ${outdir}/origdata ${outdir}/CI_HC_compare/
done 

echo "Files for dual FA comparisons are created"
#--------------------------------------------------------------------------#

#------------------------ TBSS 3 & 4 for Dual Comparisons------------------#
echo "For dual comparisons create skeleton & mean FA"

echo "MCI-CI Comparison"
cd "${outdir}/MCI_CI_compare" 
echo "tbss_3_postreg"
tbss_3_postreg -T
echo "tbss_prestats"
tbss_4_prestats 0.2 
echo "Done"


echo "MCI-HC Comparison"
cd "${outdir}/MCI_HC_compare" 
echo "tbss_3_postreg"
tbss_3_postreg -T
echo "tbss_prestats"
tbss_4_prestats 0.2 
echo "Done"


echo "CI-HC Comparison"
cd "${outdir}/CI_HC_compare" 
echo "tbss_3_postreg"
tbss_3_postreg -T
echo "tbss_prestats"
tbss_4_prestats 0.2 
echo "Done"
exit

echo 'Enter subject indexes for 3 groups.'
echo 'Enter PD-MCI'
while read line
do
MCI=("${MCI[@]}" $line)
done

echo 'Enter PD-CI'
while read line
do
CI=("${CI[@]}" $line)
done

echo 'Enter HC'
while read line
do
HC=("${HC[@]}" $line)
done
 
#----------------------------------------------------------------------------#
echo "---------------------TBSS For MD Files---------------------------------"
#Copy all MD data 
mkdir ${outdir}/MD

for i in "${input_K[@]}"
do
#ncftpput -u $USER -p $PASSWD $HOST "/PD_Patients/K_${i}/exam_1/images/DTI/DTI_32/nii/K${i}_MD.nii.gz" "${outdir}/MD/K${i}_MD.nii.gz"

##Use the following to process existing file on the PC.(FA MD Maps on your PC)
cp "${RegDir}/K${i}_MD.nii.gz" "${outdir}/MD/"
done

cd "${outdir}/MD"
for i in "${input_K[@]}"
do 
mv -v "K${i}_MD.nii.gz" "K${i}.nii.gz"
done 

for i in "${input_P[@]}"
do
#ncftpput -u $USER -p $PASSWD $HOST "/PD_Patients/PD_${i}/exam_1/images/DTI/DTI_32/nii/PD${i}_FA.nii.gz" "${outdir}/MD/PD${i}_MD.nii.gz"

##Use the following to process existing file on the PC.(FA MD Maps on your PC)
cp "${RegDir}/PD${i}_MD.nii.gz" "${outdir}/MD/"
done 

cd "${outdir}/MD"
for i in "${input_P[@]}"
do 
mv -v "PD${i}_MD.nii.gz" "PD${i}.nii.gz"
done 

cd "${outdir}"
echo "TBSS for three groups MD data" 
tbss_non_FA MD 
echo "Done"


echo " TBSS for Dual Comparisons, MD Maps "

# MCI-CI-MD Dual Comparisons
mkdir ${outdir}/MCI_CI_compare/MD_MCI_CI

for i in ${MCI[@]}
do 
cp  ${outdir}/MD/PD${i}.nii.gz ${outdir}/MCI_CI_compare/MD_MCI_CI
done

for i in ${CI[@]}
do 
cp  ${outdir}/MD/PD${i}.nii.gz ${outdir}/MCI_CI_compare/MD_MCI_CI
done

cd ${outdir}/MCI_CI_compare
tbss_non_FA MD_MCI_CI 

# CI-HC-MD Dual Comparisons
mkdir ${outdir}/CI_HC_compare/MD_CI_HC

for i in ${CI[@]}
do 
cp  ${outdir}/MD/PD${i}.nii.gz ${outdir}/CI_HC_compare/MD_CI_HC
done

for i in ${HC[@]}
do 
cp  ${outdir}/MD/K${i}.nii.gz ${outdir}/CI_HC_compare/MD_CI_HC
done

cd ${outdir}/CI_HC_compare
tbss_non_FA MD_CI_HC 

# MCI-HC-MD Dual Comparisons
mkdir ${outdir}/MCI_HC_compare/MD_MCI_HC

for i in ${MCI[@]}
do 
cp  ${outdir}/MD/PD${i}.nii.gz ${outdir}/MCI_HC_compare/MD_MCI_HC
done

for i in ${HC[@]}
do 
cp  ${outdir}/MD/K${i}.nii.gz ${outdir}/MCI_HC_compare/MD_MCI_HC
done

cd ${outdir}/MCI_HC_compare
tbss_non_FA MD_MCI_HC 

#EOF 












