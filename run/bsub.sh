#!/bin/bash
source $TestArea/../build/*/setup.sh
#Reco_tf.py --outputAODFile=AOD.pool.root --steering="doRDO_TRIG" --preExec="all:from TriggerJobOpts.TriggerFlags import TriggerFlags; TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODFULL\");" --athenaopts="--imf --perfmon --threads=1" --maxEvents=-1 --inputHITSFile=$1     # for master
MAXEVENTS=10

Reco_tf.py --autoConfiguration everything --outputAODFile=AOD.pool.root --maxEvents ${MAXEVENTS} --inputHITSFile $1 --preExec="all:from TriggerJobOpts.TriggerFlags import TriggerFlags; TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODFULL\");" --geometryVersion=ATLAS-R2-2016-01-00-01 --conditionsTag=OFLCOND-MC16-SDR-14 --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py RecJobTransforms/UseFrontier.py
