#!/bin/sh
DATE=$(date '+%Y%m%d%H%M')

source $TestArea/../build/$CMTCONFIG/setup.sh

#INPUT_RDO="/gpfs/fs2001/yfukuhar/data/user.yfukuhar.mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.recon.RDO.e3601_s3126_r9781.201806291853_EXT0/user.yfukuhar.14514992.EXT0._000004.RDO.pool.root"
INPUT_LIST="tmp_Zmumu.list"
INPUT_RDO_FOR_OUTPUT="user.yfukuhar.mc16_13TeV.Zmumu"
OUTPUT_AOD=$INPUT_RDO_FOR_OUTPUT".AOD."$DATE".root"
#CMT_CONFIG="x86_64-slc6-gcc62-opt"
#AMI_TAG="r9781"
#NFILES_PER_JOB='5'
#NEVENTS_PER_FILE='500'
#NEVENTS_PER_JOB='100'
#DESTSE='TOKYO-LCG2_SCRATCHDISK'

echo ""
echo "INPUT_LIST =   "$INPUT_LIST
echo "OUTPUT_AOD =   "$OUTPUT_AOD
echo ""


#echo "" | tee -a jediTaskID.info
#echo "LOG: " | tee -a jediTaskID.info
#
#eval $COMMAND 2>&1 | tee -a jediTaskID.info
#LOG_NAME="log_"$LOG_INDEX"_"$DATE


if [ -f "$INPUT_LIST" ] ; then
  echo $INPUT_LIST
  for INPUT_FILE in `cat $INPUT_LIST`
  do
    echo ""
    echo "INPUT_FILE =   "$INPUT_FILE
    echo ""
    TEMP_DIR=`echo "$FILE" | sed -e "s:/:_:g"`
    DIR="Output/$TEMP_DIR"
    mkdir -p $DIR
    cp ./*.sh $DIR
    cd $DIR
    COMMAND="bsub -q 2d -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --outputAODFile ${OUTPUT_AOD} --inputRDOFile ${INPUT_FILE}'"
    echo $COMMAND > tmp_athena_run.sh
    sh tmp_athena_run.sh
    cd -
  done
fi
