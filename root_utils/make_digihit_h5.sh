#!/bin/bash
#SBATCH --account=rpp-blairt2k
#SBATCH --time=0:10:0
#SBATCH --mem-per-cpu=16G
#SBATCH --output=/scratch/junjiex/log/WCTE_npztoh5/%x-%a.out
#SBATCH --error=/scratch/junjiex/log/WCTE_npztoh5/%x-%a.err
#SBATCH --cpus-per-task=1

# sets up environment and runs np_to_hit_array_hdf5.py, see that file for info on arguments, that all get passed through from this script

ulimit -c 0

#source /project/rpp-blairt2k/machine_learning/production_software/DataTools/cedar_scripts/sourceme.sh
source /home/junjiex/setup_hk.sh

SLURM_TMPDIR="${SLURM_TMPDIR:-/scratch/$USER}"
virtualenv --no-download $SLURM_TMPDIR/env
source $SLURM_TMPDIR/env/bin/activate
pip install --no-index --upgrade pip
pip install --no-index h5py

# set directory where log files will be saved
#export LOGDIR="/scratch/$USER/log/WCTE_npztoh5/"
#mkdir -p "$LOGDIR"
# cd to this directory so SLURM puts its logs there too
#cd "$LOGDIR"

#cd /home/junjiex/pro-junjiex/WatChMaL/DataTools/root_utils

# initially save to SLURM_TMPDIR for speed
#args=("$@")
#for i in "${!args[@]}"; do
#  if [[ ${args[$i]} == "-o" ]]; then
#    outfile="${args[$i+1]}"
#    tmpfile="${SLURM_TMPDIR}/$(basename $outfile)"
#    args[$i+1]="$tmpfile"
#    break
#  fi
#done

echo "python np_to_digihit_array_hdf5.py $@"
python /home/junjiex/pro-junjiex/WatChMaL/DataTools/root_utils/np_to_digihit_array_hdf5.py "$@"

#echo "cp $tmpfile $outfile"
#cp "$tmpfile" "$outfile"
