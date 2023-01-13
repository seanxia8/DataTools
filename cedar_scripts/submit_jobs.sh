#!/bin/bash
# Example script to set up and submit batch jobs

# exit when any command fails
set -e

# initial environment setup
#export DATATOOLS=/project/rpp-blairt2k/machine_learning/production_software/DataTools
export DATATOOLS=/home/junjiex/pro-junjiex/WatChMaL/DataTools
cd $DATATOOLS/cedar_scripts
#source sourceme.sh %use local ROOT, G4, and WCSim builds specified in ~/.bashrc

# name and output data directory for this run
name=WCTEmPMT_test
data_dir=/home/junjiex/pro-junjiex/WatChMaL/outputs/WCTE_MC

# Run setup scripts
source setup_jobs.sh "$name" "$data_dir"

# set directory where log files will be saved
export LOGDIR="/scratch/$USER/log/$name/"
mkdir -p "$LOGDIR"
# cd to this directory so SLURM puts its logs there too
cd "$LOGDIR"

# submit jobs with desired options
JOBTIME=`date` sbatch --output="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-e-%J.txt" --error="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-e-%J.txt" --time=23:59:00 --array=0-99 --job-name=e "$DATATOOLS/cedar_scripts/run_WCSim_job.sh" "$name" "$data_dir" -n 1000 -e 100 -E 1500 -P e- -d 4pi -p fix -x 0 -y 0 -z 0
JOBTIME=`date` sbatch --output="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-mu-%J.txt" --error="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-mu-%J.txt" --time=23:59:00 --array=0-99 --job-name=mu "$DATATOOLS/cedar_scripts/run_WCSim_job.sh" "$name" "$data_dir" -n 1000 -e 100 -E 1500 -P mu- -d 4pi -p fix -x 0 -y 0 -z 0
JOBTIME=`date` sbatch --output="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-gamma-%J.txt" --error="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-gamma-%J.txt" --time=23:59:00 --array=0-99 --job-name=gamma "$DATATOOLS/cedar_scripts/run_WCSim_job.sh" "$name" "$data_dir" -n 1000 -e 100 -E 1500 -P gamma -d 4pi -p fix -x 0 -y 0 -z 0
JOBTIME=`date` sbatch --output="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-pi0-%J.txt" --error="$DATATOOLS/cedar_scripts/slurm_log/log-WCSim-pi0-%J.txt" --time=23:59:00 --array=0-99 --job-name=pi0 "$DATATOOLS/cedar_scripts/run_WCSim_job.sh" "$name" "$data_dir" -n 1000 -e 100 -E 1500 -P pi0 -d 4pi -p fix -x 0 -y 0 -z 0
