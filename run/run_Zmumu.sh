#!/bin/sh

DATE=$(date '+%Y%m%d%H%M')
dateMMDD=$(date '+%m%d')
bque=1d
source $TestArea/../build/*/setup.sh
INPUT_LIST="./lists/Zmumu.361107.list"

if [ -f $INPUT_LIST ] ; then
  for INPUT_FILE in `cat $INPUT_LIST`
  do
    OLD_DIR=$PWD
    echo "INPUT_FILE = "$INPUT_FILE
    TMP_DIR=`echo "$INPUT_FILE" | sed -e "s:/:_:g"`
    SUB_TAR="/gpfs/fs7001/ktaniguc/outputfile/L2SA4Close-By_newAlg/Zmumu/$DATE/$TMP_DIR/processing"
    mkdir -p $SUB_TAR
    cp ./*.sh $SUB_TAR
    cd $SUB_TAR
    COMMAND_FORCLEAR="mv AOD* ../ && cd ../ && rm -r ./processing"
    echo $COMMAND_FORCLEAR > clear.sh
    bsub -q ${bque} -o log.out "./HITS2AOD.sh ${INPUT_FILE} && source clear.sh"
    cd $OLD_DIR
  done
fi
