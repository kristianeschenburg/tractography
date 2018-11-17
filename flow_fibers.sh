#/bin/bash

subject=$1
upper=$2
lower=$3
samples=$4

PTX3=/mnt/parcellator/parcellation/Software/fslbuild/fsl/src/ptx3/probtrackx3
hcp_dir=/mnt/parcellator/parcellation/HCP/Connectome_4
data_dir=/mnt/parcellator/parcellation/parcellearning/Data

${PTX3} -s ${hcp_dir}/${subject}/Diffusion.bedpostX/merged \
        -m ${hcp_dir}/${subject}/Diffusion/nodif_brain_mask \
        -x ${data_dir}/FlowLines/${subject}.L.white.Flow.${upper}.nb.10.diff.5.acpc.surf.gii \
        --stop=${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii \
        --dir=${data_dir}/FlowFibers/${subject}.L.${upper}.${lower} --forcedir \
        --omatrix3 --disttresh3=${lenthresh} \
        --target3=${data_dir}/FlowLines/${subject}.L.white.Flow.${upper}.nb.10.diff.5.acpc.surf.gii \
        --lrtarget3=${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii \
        --seedref=${conn_dir}/${subject}/T1w/T1w_acpc_dc_restore.nii.gz \
        --forceangle \
        --initdir=${data_dir}/FlowLines/${subject}.L.white.FlowAngle.nb.10.diff.5.acpc.${lower}.${upper}.csv \
        --innersurf=${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.white.32k_fs_LR.surf.gii \
        --outersurf=${conn_dir}/${subject}/T1w/fsaverage_LR32k/${subject}.L.pial.32k_fs_LR.surf.gii \
        -V 1 -P ${samples} --opd --ompl --onewayonly --savepoints