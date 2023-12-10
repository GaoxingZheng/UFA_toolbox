#!/bin/bash

### AUTHOR : Gaoxing Zheng
### Institution: Zhongshan Hospital, Fudan University
### EMAIL CONTACT: zheng_gao_xing@163.com
### DATE: 2022-04-14
### REFERENCE: Hsu, C. C. H., Chong, S. T., Kung, Y. C., Kuo, K. T., Huang, C. C., & Lin, C. P. (2023).
# Integrated diffusion image operator (iDIO): A pipeline for automated configuration and processing of diffusion MRI data
# (Vol. 44, No. 7, pp. 2669-2683). Hoboken, USA: John Wiley & Sons, Inc..
### STATEMENT: This code is from https://github.com/iDIO4dMRI/iDIO. If it's useful in your study, please cite the above reference.

UFA_T1_N4BiasFieldCorrection(){

AtlasDir="$1"

OutputFolder="$2"

# Ants N4 bias correction
N4BiasFieldCorrection -d 3 -v 0 -s 4 -b [180] -c [50x50x50, 0.0 ] -i ${OutputFolder}/T1/T1w-deGibbs.nii.gz -o [${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz, ${OutputFolder}/T1/T1w_BiasField.nii.gz ]

#Ants brain extraction (using OASIS prior)

if [ ! -e ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz ]; then
    echo "Running Brain Extraction with antsBrainExtraction"
    antsBrainExtraction.sh -d 3 -a ${OutputFolder}/T1/T1w-deGibbs-BiasCo.nii.gz -e ${AtlasDir}/MNI/MICCAI2012/T_template0.nii.gz -m ${AtlasDir}/MNI/MICCAI2012/T_template0_BrainCerebellumProbabilityMask.nii.gz -f ${AtlasDir}/MNI/MICCAI2012/T_template0_BrainCerebellumRegistrationMask.nii.gz -o T1w-deGibbs-BiasCo-
    rm -r ./T1w-deGibbs-BiasCo-
    mv ./T1w-deGibbs-BiasCo-BrainExtractionBrain.nii.gz ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Brain.nii.gz
    mv ./T1w-deGibbs-BiasCo-BrainExtractionMask.nii.gz ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Mask.nii.gz
    mv ./T1w-deGibbs-BiasCo-BrainExtractionPrior0GenericAffine.mat ${OutputFolder}/T1/T1w-deGibbs-BiasCo-Prior0GenericAffine.mat
else
    echo "Brain Mask Found: antsBrainExtraction Skipped"
fi

echo 'This operator generates the N4 Bias Field Corrected T1 image!'

echo 'T1 Brain Extraction with antsBrainExtraction completed!'

}

UFA_T1_N4BiasFieldCorrection $1 $2



