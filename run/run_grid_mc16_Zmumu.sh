#!/bin/sh
DATE=$(date '+%Y%m%d%H%M')

source $TestArea/../build/$CMTCONFIG/setup.sh

INPUT_RDO="user.yfukuhar.mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.recon.RDO.e3601_s3126_r9781.201806291853_EXT0"
OUTPUT_AOD=$INPUT_RDO"."$DATE".AOD.pool.root"
CMT_CONFIG="x86_64-slc6-gcc62-opt"
AMI_TAG="r9781"

echo ""
echo "INPUT_RDO =    "$INPUT_RDO
echo "OUTPUT_AOD =   "$OUTPUT_AOD
echo ""

#LOG_NAME="log_"$LOG_INDEX"_"$DATE

SUBMIT_AREA="SubmitArea_"$DATE
mkdir $SUBMIT_AREA
cd $SUBMIT_AREA
cp ../*.sh ./

echo "pathena --trf "Reco_tf.py --AMIConfig r9311 --maxEvents %MAXEVENTS --skipEvents %SKIPEVENTS --outputAODFile $OUTPUT_AOD --inputRDOFile $INPUT_RDO"  --cmtConfig ${CMTCONFIG} --nFilesPerJob 1 ---nEventsPerFile 1000 --nEventsPerJob 100"

pathena --trf "Reco_tf.py --AMIConfig $AMI_TAG --maxEvents %MAXEVENTS --skipEvents %SKIPEVENTS --outputAODFile $OUTPUT_AOD --inputRDOFile $INPUT_RDO" --cmtConfig $CMTCONFIG --nFilesPerJob 5 ---nEventsPerFile 1000 --nEventsPerJob 100

