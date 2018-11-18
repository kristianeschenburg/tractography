#/bin/bash

subject=$1
samples=$2
lenthresh=$3

PTX3=/mnt/parcellator/parcellation/Software/fslbuild/fsl/src/ptx3/probtrackx3
hcp_dir=/mnt/parcellator/parcellation/HCP/Connectome_4
data_dir=/mnt/parcellator/parcellation/parcellearning/Data

${PTX3} -s ${hcp_dir}/${subject}/Diffusion.bedpostX/merged \
        -m ${hcp_dir}/${subject}/Diffusion/nodif_brain_mask \
        -x ${data_dir}/FlowSurfaces/${subject}.L.white.acpc.gii \
        --stop=${data_dir}/Surfaces/${subject}.L.white.32k_fs_LR.acpc_dc.surf.gii \
        --dir=${data_dir}/WhiteFibers/${subject}.L.W2W.Len.${lenthresh} --forcedir \
        --seedref=${data_dir}/Structural/${p}.T1w_acpc_dc_restore.nii.gz \
        --omatrix3 \
        --target3=${data_dir}/FlowSurfaces/${subject}.L.white.acpc.gii
        --lrtarget3=${data_dir}/Surfaces/${subject}.L.white.32k_fs_LR.acpc_dc.surf.gii
        --forcefirststep \
        -V 1 -P ${samples} --opd --ompl --onewayonly --distthresh1=${lenthresh}
