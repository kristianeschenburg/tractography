#/bin/bash

subject=$1
samples=$2

PTX2=/mnt/parcellator/parcellation/Software/fslbuild/fsl/src/ptx3/probtrackx3
hcp_dir=/mnt/parcellator/parcellation/HCP/Connectome_4
data_dir=/mnt/parcellator/parcellation/parcellearning/Data
conn_dir=/Connectome_4

${PTX3} -s ${hcp_dir}/${subject}/Diffusion.bedpostX/merged \
        -m ${hcp_dir}/${subject}/Diffusion/nodif_brain_mask \
        -x ${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii \
        --stop=${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii \
        --dir=${data_dir}/WhiteFibers/${subject}.L.W2W --forcedir \
        --seedref=${conn_dir}/${subject}/T1w/T1w_acpc_dc_restore.nii.gz \
        --omatrix1 \
        --forcefirststep \
        -V 1 -P ${samples} --opd --ompl --onewayonly
