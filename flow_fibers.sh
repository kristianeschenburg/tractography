#/bin/bash

subject=$1
upper=$2
lower=$3
samples=$4
lenthresh=$5

PTX3=/mnt/parcellator/parcellation/Software/fslbuild/fsl/src/ptx3/probtrackx3
hcp_dir=/mnt/parcellator/parcellation/HCP/Connectome_4
data_dir=/mnt/parcellator/parcellation/parcellearning/Data

${PTX3} -s ${hcp_dir}/${subject}/Diffusion.bedpostX/merged \
        -m ${hcp_dir}/${subject}/Diffusion/nodif_brain_mask \
        -x ${data_dir}/FlowSurfaces/${subject}.L.white.Flow.${upper}.nb.10.diff.5.acpc.surf.gii \
        --stop=${data_dir}/Surfaces/${subject}.L.white.32k_fs_LR.acpc_dc.surf.gii \
        --dir=${data_dir}/FlowFibers/${subject}.L.Flow.${upper}.${lower}.Dist.${lenthresh} --forcedir \
	--omatrix1.5 \
	--omatrix1.5_mask=${data_dir}/FlowSurfaces/${subject}.L.WholeIPL.func.gii \
        --omatrix3 \
        --target3=${data_dir}/FlowSurfaces/${subject}.L.white.Flow.${upper}.nb.10.diff.5.acpc.surf.gii \
        --lrtarget3=${data_dir}/Surfaces/${subject}.L.white.32k_fs_LR.acpc_dc.surf.gii \
        --seedref=${data_dir}/Structural/${subject}.T1w_acpc_dc_restore.nii.gz \
        --forceangle \
        --initdir=${data_dir}/FlowLines/${subject}.L.white.FlowAngle.nb.10.diff.5.acpc.${lower}.${upper}.csv \
        --innersurf=${data_dir}/Surfaces/${subject}.L.white.32k_fs_LR.acpc_dc.surf.gii \
        --outersurf=${data_dir}/Surfaces/${subject}.L.pial.32k_fs_LR.acpc_dc.surf.gii \
        -V 1 -P ${samples} --opd --ompl --onewayonly \
	--distthresh=${lenthresh} \
	--distthresh1=${lenthresh} \
	--distthresh3=${lenthresh}
